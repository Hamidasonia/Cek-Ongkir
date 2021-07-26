import 'package:cek_ongkir_app/common/constans.dart';

const kGLOG_TAG = "[$kSAppName]";
const kGLOG_ENABLE = true;

printLog(dynamic data) {
  if (kGLOG_ENABLE) {
    print("[${DateTime.now().toUtc()}]$kGLOG_TAG${data.toString()}");
  }
}

const kGPackageName = "id.nesd.template";
const kGApiKey = "cb230e5d468e95fab4aa430a05dacb49";