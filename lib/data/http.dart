import 'dart:async';
import 'dart:io';

import 'package:cek_ongkir_app/common/configs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Http {
  static Future post({
    @required String url,
    @required Map<String, dynamic> header,
    @required dynamic body,
  }) async {
    try {
      return await http.post(
        Uri.parse(url),
        headers: header,
        body: body,
      );
    } on TimeoutException catch (e) {
      print(e);
      return Future.error(kERTO);
    } on SocketException catch (e) {
      print(e);
      return Future.error(kEKoneksi);
    } on http.ClientException catch (e) {
      print(e);
      return Future.error(kEClient);
    }
  }

  static Future get({
    @required String url,
    @required Map<String, dynamic> header,
  }) async {
    try {
      return await http.get(
        Uri.parse(url),
        headers: header,
      );
    } on TimeoutException catch (e) {
      print(e);
      return Future.error(kERTO);
    } on SocketException catch (e) {
      print(e);
      return Future.error(kEKoneksi);
    } on http.ClientException catch (e) {
      print(e);
      return Future.error(kEClient);
    }
  }

  static Future delete({
    @required String url,
    @required Map<String, dynamic> header,
  }) async {
    try {
      return await http.delete(
        Uri.parse(url),
        headers: header,
      );
    } on TimeoutException catch (e) {
      print(e);
      return Future.error(kERTO);
    } on SocketException catch (e) {
      print(e);
      return Future.error(kEKoneksi);
    } on http.ClientException catch (e) {
      print(e);
      return Future.error(kEClient);
    }
  }
}
