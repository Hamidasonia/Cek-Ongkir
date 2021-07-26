import 'package:cek_ongkir_app/common/configs.dart';
import 'package:cek_ongkir_app/data/repo.dart';
import 'package:cek_ongkir_app/model/app/singleton_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;

final _repo = new Repo();
String _token;

class Request {
  Future<http.Response> province() {
    return _repo.province();
  }

  Future<dio.Response> city({@required String provinceId}) {
    return _repo.city(cityParams: {"province": provinceId});
  }

  Future<http.Response> cost(
      {@required String originCity,
      @required String destinationCity,
      @required int weight}) {
    return _repo.cost(costBody: {
      "origin": originCity,
      "destination": destinationCity,
      "weight": weight,
      "courier": "jne",
    });
  }

  Future<http.Response> dataCovid() {
    return _repo.dataCovid();
  }
}