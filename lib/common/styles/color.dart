import 'package:cek_ongkir_app/tool/hex_color.dart';
import 'package:flutter/material.dart';

final hPrimary = HexColor("#05717e");
final hSecondary = HexColor("#68cce6");
final hBackground = HexColor("#f2f2f2");

final MaterialColor mPrimary = _convertMateial(5, 113, 126);
final MaterialColor mSecondary = _convertMateial(104, 204, 230);
final MaterialColor mBackground = _convertMateial(242, 242, 242);

MaterialColor _convertMateial(int red, int green, int blue) {
  Map<int, Color> _colorCodes = {
    50: Color.fromRGBO(red, green, blue, .1),
    100: Color.fromRGBO(red, green, blue, .2),
    200: Color.fromRGBO(red, green, blue, .3),
    300: Color.fromRGBO(red, green, blue, .4),
    400: Color.fromRGBO(red, green, blue, .5),
    500: Color.fromRGBO(red, green, blue, .6),
    600: Color.fromRGBO(red, green, blue, .7),
    700: Color.fromRGBO(red, green, blue, .8),
    800: Color.fromRGBO(red, green, blue, .9),
    900: Color.fromRGBO(red, green, blue, 1),
  };

  return new MaterialColor(0xFF93cd48, _colorCodes);
}
