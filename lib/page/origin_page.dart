import 'dart:convert';
import 'package:cek_ongkir_app/data/request.dart';
import 'package:cek_ongkir_app/model/city.dart' as resultCity;
import 'package:cek_ongkir_app/model/province.dart' as resultProvince;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  GlobalKey<ScaffoldState> _scaffoldKey;
  Request _request;

  Future _provinceFuture;
  resultProvince.Province _provinceModel;

  resultCity.City _cityModelOrigin;
  resultProvince.Result _selectProvinceOrigin;
  resultCity.Result _selectCityOrigin;
  Future _cityOriginFuture;

  resultCity.City _cityModelDestinasi;
  resultProvince.Result _selectProvinceDestinasi;
  resultCity.Result _selectCityDestinasi;
  Future _cityDestinasiFuture;

  final TextEditingController _beratController = TextEditingController();
  FocusNode _focusNode;

  bool _onProcess;
  String _hasilCost;

  @override
  void initState() {
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) _beratController.clear();
    });
    super.initState();
    _scaffoldKey = new GlobalKey<ScaffoldState>();
    _request = new Request();
    _provinceFuture = _request.province();
    _onProcess = false;
  }

  void _onSubmit() async {
    if (!_onProcess) {
      setState(() {
        _onProcess = true;
      });
      await _request.cost(
        originCity: _selectCityOrigin.cityId,
        destinationCity: _selectCityDestinasi.cityId,
        weight: int.parse(_beratController.text),
      ).then((succes) {
        if(succes.statusCode == 200){
          setState(() {

            Map<String, dynamic> body = jsonDecode(succes.body);
            List results = body["rajaongkir"]["results"];
            String nama;
            int cost;
            if(results != null && results.isNotEmpty){
              if (results[0].containsKey("name")){
                nama = results[0]["name"];
              }
              if(results[0].containsKey("costs")){
                if(results[0]["costs"] != null && results[0]["costs"].isNotEmpty){
                  if(results[0]["costs"].first.containsKey("cost")){
                    cost = results[0]["costs"].first["cost"][0]["value"];
                  }
                }
              }
            }
            _hasilCost = "Nama : ${nama ?? 'Tidak ada'}\nCost : Rp. ${cost ?? 0}";
          });
        }else{
          setState(() {
            _hasilCost = "Gagal";
          });
        }
      }).catchError((error){
        setState(() {
          _hasilCost = "$error";
        });
      });
      setState(() {
        _onProcess = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cek Ongkir"),
      ),
      key: _scaffoldKey,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        width: size.width,
        child: Stack(
          children: [
            FutureBuilder(
              future: _provinceFuture,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none: //ketika future tidak berjalan
                  case ConnectionState.active: // ketika future berjalan
                  case ConnectionState.waiting: //ketika future menunggu
                    return Center(
                      child: CircularProgressIndicator(),
                    ); //mengembalikan widget loading untuk case none, active & waiting
                  case ConnectionState.done: // ketika future sudah selesai
                    if (snapshot.hasData) {
                      // jika ada data
                      http.Response res = snapshot.data;
                      if (res.statusCode == 200) {
                        // jika statuscode 200 (OK)
                        _provinceModel = resultProvince.Province.fromJson(jsonDecode(
                            res.body)); //assign data response ke model yg sudah dibuat
                        return _showDataProvince(); //mengembalikan widget yg berisi informasi dari req tsb
                      } else {
                        return Text(
                            'Unable to load data(${res.statusCode}) : \n${jsonDecode(res.body)['message']}'); //jika statuscode tidak 200
                      }
                    } else if (snapshot.hasError) {
                      //jika error
                      return Text('Unable to load data : \n${snapshot.error}');
                    }
                }
                return Container(
                  child: Text("Gagal"),
                ); // default widget
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _showDataProvince() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text("Pilih Asal Provinsi"),
          DropdownButton(
            hint: Text("Select Province"),
            value: _selectProvinceOrigin == null
                ? null
                : jsonEncode(_selectProvinceOrigin.toJson()),
            items: _provinceModel.rajaongkir.results
                .map((resultProvince.Result item) {
              return DropdownMenuItem(
                child: Text(item.province),
                value: jsonEncode(item.toJson()),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectProvinceOrigin =
                    resultProvince.Result.fromJson(jsonDecode(value));
                _selectCityOrigin = null;
                // _cityOriginFuture =
                //     _request.city(provinceId: _selectProvinceOrigin.provinceId);
              });
            },
          ),
          FutureBuilder(
            future: _cityOriginFuture,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none: //ketika future tidak berjalan
                  return Text("Pilih Provinsi Terlebih dahulu");
                case ConnectionState.active: // ketika future berjalan
                case ConnectionState.waiting: //ketika future menunggu
                  return Center(
                    child: CircularProgressIndicator(),
                  ); //mengembalikan widget loading untuk case none, active & waiting
                case ConnectionState.done: // ketika future sudah selesai
                  if (snapshot.hasData) {
                    // jika ada data
                    dio.Response res = snapshot.data;
                    if (res.statusCode == 200) {
                      // jika statuscode 200 (OK)
                      _cityModelOrigin = resultCity.City.fromJson(res
                          .data); //assign data response ke model yg sudah dibuat
                      return _showDataCity(); //mengembalikan widget yg berisi informasi dari req tsb
                    } else {
                      return Text(
                          'Unable to load data(${res.statusCode}) : \n${jsonDecode(res.data)['message']}'); //jika statuscode tidak 200
                    }
                  } else if (snapshot.hasError) {
                    //jika error
                    return Text('Unable to load data : \n${snapshot.error}');
                  }
              }
              return Container(
                child: Text("Gagal"),
              ); // default widget
            },
          ),
          SizedBox(height: 40.0),
          Text("Pilih Provinsi Tujuan"),
          DropdownButton(
            hint: Text("Select Province"),
            value: _selectProvinceDestinasi == null
                ? null
                : jsonEncode(_selectProvinceDestinasi.toJson()),
            items: _provinceModel.rajaongkir.results
                .map((resultProvince.Result item) {
              return DropdownMenuItem(
                child: Text(item.province),
                value: jsonEncode(item.toJson()),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectProvinceDestinasi =
                    resultProvince.Result.fromJson(jsonDecode(value));
                _selectCityDestinasi = null;
                // _cityDestinasiFuture = _request.city(
                //     provinceId: _selectProvinceDestinasi.provinceId);
              });
            },
          ),
          FutureBuilder(
            future: _cityDestinasiFuture,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none: //ketika future tidak berjalan
                  return Text("Pilih Provinsi Terlebih dahulu");
                case ConnectionState.active: // ketika future berjalan
                case ConnectionState.waiting: //ketika future menunggu
                  return Center(
                    child: CircularProgressIndicator(),
                  ); //mengembalikan widget loading untuk case none, active & waiting
                case ConnectionState.done: // ketika future sudah selesai
                  if (snapshot.hasData) {
                    // jika ada data
                    dio.Response res = snapshot.data;
                    if (res.statusCode == 200) {
                      // jika statuscode 200 (OK)
                      _cityModelDestinasi = resultCity.City.fromJson(res
                          .data); //assign data response ke model yg sudah dibuat
                      return _showDataCityDestinasi(); //mengembalikan widget yg berisi informasi dari req tsb
                    } else {
                      return Text(
                          'Unable to load data(${res.statusCode}) : \n${jsonDecode(res.data)['message']}'); //jika statuscode tidak 200
                    }
                  } else if (snapshot.hasError) {
                    //jika error
                    return Text('Unable to load data : \n${snapshot.error}');
                  }
              }
              return Container(
                child: Text("Gagal"),
              ); // default widget
            },
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: TextField(
              focusNode: _focusNode,
              controller: _beratController,
              //UNTUK MENG-HANDLE VALUENYA KITA GUNAKAN CONTROLLER
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Masukkan Berat',
                  labelText: 'Berat'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
                child: Text(_onProcess ? "memuat" : "cek"),
                highlightElevation: 2,
                color: Colors.redAccent,
                textColor: Colors.white,
                // onPressed:
                //     _onSubmit //KETIKA TOMBOLNYA DITEKAN, MAKA AKAN MENJALANKAN FUNGSI cekResi
                ),
          ),
          // Card(
          //   elevation: 4,
          //   child: Column(
          //     children: [
          //       Text('$kurir'),
          //       Text('$originCity'),
          //       Text('$destinationCity'),
          //       Text('$harga')
          //     ],
          //   ),
          // ),
          Text("${_hasilCost ?? ''}")
        ],
      ),
    );
  }

  Widget _showDataCity() {
    return Column(
      children: [
        Text("Pilih Kota"),
        DropdownButton(
          hint: Text("Select City"),
          value: _selectCityOrigin == null
              ? null
              : jsonEncode(_selectCityOrigin.toJson()),
          items:
              _cityModelOrigin.rajaongkir.results.map((resultCity.Result item) {
            return DropdownMenuItem(
              child: Text(item.cityName),
              value: jsonEncode(item.toJson()),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectCityOrigin = resultCity.Result.fromJson(jsonDecode(value));
            });
          },
        ),
      ],
    );
  }

  Widget _showDataCityDestinasi() {
    return Column(
      children: [
        Text("Pilih Kota Tujuan"),
        DropdownButton(
          hint: Text("Select City"),
          value: _selectCityDestinasi == null
              ? null
              : jsonEncode(_selectCityDestinasi.toJson()),
          items: _cityModelDestinasi.rajaongkir.results
              .map((resultCity.Result item) {
            return DropdownMenuItem(
              child: Text(item.cityName),
              value: jsonEncode(item.toJson()),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectCityDestinasi =
                  resultCity.Result.fromJson(jsonDecode(value));
            });
          },
        ),
      ],
    );
  }

  // Widget _cekOngkir() {
  //   return Container(
  //     margin: EdgeInsets.symmetric(horizontal: 30),
  //     child: ListView(
  //       children: [
  //         _showDataProvince(
  //             kurir: "jne",
  //             originCity: "Semarang",
  //             destinationCity: "Surabaya",
  //             harga: "19670")
  //       ],
  //     ),
  //   );
  // }
}
