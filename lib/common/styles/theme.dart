import 'package:google_fonts/google_fonts.dart';
import 'package:cek_ongkir_app/common/styles.dart';
import 'package:flutter/material.dart';

ThemeData tdMain(BuildContext context) => ThemeData(
      primarySwatch: mSecondary,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: hBackground,
      textTheme: GoogleFonts.montserratTextTheme(
        Theme.of(context).textTheme,
      ),
      primaryColor: hSecondary,
      primaryColorDark: hPrimary,
      primaryTextTheme: TextTheme(headline6: TextStyle(color: hPrimary)),
      dividerColor: hSecondary,
      appBarTheme: AppBarTheme(
        color: Colors.white,
        iconTheme: IconThemeData(color: hPrimary),
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: hPrimary),
        hintStyle: TextStyle(color: hPrimary),
        hoverColor: hPrimary,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: hPrimary),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: hPrimary),
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: hPrimary,
      ),
    );
