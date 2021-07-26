import 'package:cek_ongkir_app/common/configs.dart';
import 'package:cek_ongkir_app/common/constans.dart';
import 'package:cek_ongkir_app/common/styles.dart';
import 'package:cek_ongkir_app/page/cek_kasus_covid19.dart';
import 'package:cek_ongkir_app/page/cek_page.dart';
import 'package:flutter/material.dart';

class CekOngkirApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kSAppName,
      theme: tdMain(context),
      home: CekOngkirPage(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: kLDelegates,
      supportedLocales: kLSupports,
    );
  }
}