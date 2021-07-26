import 'dart:async';
import 'dart:io';

import 'package:cek_ongkir_app/common/configs.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as d;

class Dio {
  static Future post({
    @required String url,
    @required Map<String, dynamic> header,
    @required Map<String, dynamic> body,
    Map<String, dynamic> param,
  }) async {
    try {
      return await d.Dio().post(
        url,
        queryParameters: param ,
        data: body,
        options: d.Options(
          headers: header,
        ),
      );
    } on TimeoutException catch (e) {
      print(e);
      return Future.error(kERTO);
    } on SocketException catch (e) {
      print(e);
      return Future.error(kEKoneksi);
    }on d.DioError catch(e){
      print(e);
      return Future.error(e);
    }
  }

  static Future get({
    @required String url,
    @required Map<String, dynamic> header,
    Map<String, dynamic> param,
  }) async {
    try {
      return await d.Dio().get(
        url,
        queryParameters: param,
        options: d.Options(
          headers: header,
        ),
      );
    } on TimeoutException catch (e) {
      print(e);
      return Future.error(kERTO);
    } on SocketException catch (e) {
      print(e);
      return Future.error(kEKoneksi);
    }
  }
}