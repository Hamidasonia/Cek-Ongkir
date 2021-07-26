import 'dart:async';
import 'dart:convert';

import 'package:cek_ongkir_app/common/configs.dart';
import 'package:cek_ongkir_app/common/constans.dart';
import 'package:cek_ongkir_app/data/api.dart';
import 'package:cek_ongkir_app/data/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cek_ongkir_app/data/http.dart';
import 'package:dio/dio.dart' as dio;

final _api = new API();

class Repo {

  Future<http.Response> province() async {
    return await Http.get(url: _api.province, header: kDHeader);
  }

  Future<dio.Response> city({@required Map<String, dynamic> cityParams}) async {
    return await Dio.get(url: _api.city, header: kDHeader, param: cityParams);
  }

  Future<http.Response> cost({@required Map<String, dynamic> costBody}) async {
    return await Http.post(url: _api.cost, header: kDHeader, body: jsonEncode(costBody));
  }

  Future<http.Response> dataCovid() async {
    return await Http.get(url: _api.province, header: kDHeader);
  }

  Future<http.Response> getData() async {
    return await Http.get(url: _api.baseUrl, header: kDHeader);
  }
}
