import 'package:cek_ongkir_app/common/constans.dart';

Map<String, String> kDHeader = {
  "Accept": "application/json",
  "Content-Type": kGApiKey != null ?  "application/json" :  "application/x-www-form-urlencoded",
  if (kGApiKey != null) "Authorization": kGApiKey,
    };