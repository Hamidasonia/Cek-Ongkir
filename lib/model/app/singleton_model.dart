import 'package:cek_ongkir_app/model/user_model.dart';

export 'package:cek_ongkir_app/model/user_model.dart';

class SingletonModel {
  static final SingletonModel _singleton = SingletonModel._internal();

  factory SingletonModel() {
    return _singleton;
  }

  SingletonModel._internal();

  static SingletonModel get shared {
    return _singleton;
  }

  bool isLoggedIn;
  UserModel user;
}
