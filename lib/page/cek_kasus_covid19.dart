// import 'dart:convert';
//
// import 'package:cek_ongkir_app/data/request.dart';
// import 'package:cek_ongkir_app/model/data_covid.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
//
// class CekKasusCovidIndonesia extends StatefulWidget {
//   @override
//   _CekKasusCovidIndonesiaState createState() => _CekKasusCovidIndonesiaState();
// }
//
// class _CekKasusCovidIndonesiaState extends State<CekKasusCovidIndonesia> {
//   GlobalKey<ScaffoldState> _scaffoldKey;
//   Request _request;
//   Future _dataProvinceFuture;
//   // Future _dataGenderFuture;
//   DataCovid _dataCovidModel;
//   ListDatum _selectedProvince;
//   // String _selectedGender;
//   bool _onProcess;
//   String _hasilCek;
//
//   @override
//   void initState() {
//     _scaffoldKey = new GlobalKey<ScaffoldState>();
//     _request = new Request();
//     _dataProvinceFuture = _request.dataCovid();
//     // _dataGenderFuture = _request.dataCovid();
//     _onProcess = false;
//     super.initState();
//   }
//
//   void _onSubmit() async {
//     if (!_onProcess){
//       setState(() {
//         _onProcess = true;
//       });
//       await _request.dataCovid(
//       ). then((sukses) {
//         if(sukses.statusCode == 200){
//          setState(() {
//            Map<String, dynamic> body = jsonDecode(sukses.body);
//            List list = body["list_data"];
//            int jumlahKasus;
//
//            Map<String, dynamic> data = list.firstWhere((element) => element["key"] == _selectedProvince.key);
//
//            if (data.containsKey("jumlah_kasus")){
//              jumlahKasus = data["jumlah_kasus"];
//            }
//            _hasilCek = "Provinsi : ${_selectedProvince.key ?? 'Tidak ada'}\nJumlah yang terkena : ${jumlahKasus ?? 0}";
//          });
//         }else{
//           setState(() {
//             _hasilCek = "Gagal";
//           });
//         }
//       }).catchError((error){
//         setState(() {
//           _hasilCek = "$error";
//         });
//       });
//       setState(() {
//         _onProcess = false;
//       });
//     }
//   }
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Cek Data Covid"),
//       ),
//       key: _scaffoldKey,
//       body: _buildBody(),
//     );
//   }
//
//   Widget _buildBody() {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       padding: const EdgeInsets.all(16.0),
//       width: size.width,
//       child: FutureBuilder(
//         future: _dataProvinceFuture,
//         builder: (context, snapshot) {
//           switch (snapshot.connectionState) {
//             case ConnectionState.none: //ketika future tidak berjalan
//             case ConnectionState.active: // ketika future berjalan
//             case ConnectionState.waiting: //ketika future menunggu
//               return Center(
//                 child: CircularProgressIndicator(),
//               ); //mengembalikan widget loading untuk case none, active & waiting
//             case ConnectionState.done: // ketika future sudah selesai
//               if (snapshot.hasData) {
//                 // jika ada data
//                 http.Response res = snapshot.data;
//                 if (res.statusCode == 200) {
//                   // jika statuscode 200 (OK)
//                   // _listDatum.key = ListDatum.fromJson(jsonDecode(res.body)); //assign data response ke model yg sudah dibuat
//                   _dataCovidModel = DataCovid.fromJson(jsonDecode(res.body));
//                   return _showProvinceCovid(); //mengembalikan widget yg berisi informasi dari req tsb
//                 } else {
//                   return Text(
//                       'Unable to load data(${res.statusCode}) : \n${jsonDecode(res.body)['message']}'); //jika statuscode tidak 200
//                 }
//               } else if (snapshot.hasError) {
//                 //jika error
//                 return Text('Unable to load data : \n${snapshot.error}');
//               }
//           }
//           return Container(
//             child: Text("Gagal"),
//           ); // default widget
//         },
//       ),
//     );
//   }
//
//   Widget _showProvinceCovid() {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           Text("PILIH PROVINSI"),
//           DropdownButton(
//             hint: Text("Select Province"),
//             value: _selectedProvince == null
//                 ? null
//                 : jsonEncode(_selectedProvince.toJson()),
//             items: _dataCovidModel.listData.map((ListDatum item) {
//               return DropdownMenuItem(
//                 child: Text(item.key),
//                 value: jsonEncode(item.toJson()),
//               );
//             }).toList(),
//             onChanged: (value) {
//               setState(() {
//                 _selectedProvince = ListDatum.fromJson(jsonDecode(value));
//               });
//             },
//           ),
//           SizedBox(height: 20.0),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: MaterialButton(
//               child: Text(_onProcess ? "memuat" : "cek"),
//               highlightElevation: 2,
//               color: Colors.redAccent,
//               textColor: Colors.white,
//               onPressed:
//                   _onSubmit //KETIKA TOMBOLNYA DITEKAN, MAKA AKAN MENJALANKAN FUNGSI cekData
//             ),
//           ),
//           Text("${_hasilCek ?? ''}")
//         ],
//       ),
//     );
//   }
// }