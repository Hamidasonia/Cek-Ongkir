import 'package:cek_ongkir_app/dialog/exit_dialog.dart';
import 'package:cek_ongkir_app/page/origin_page.dart';
import 'package:flutter/material.dart';

class CekOngkirPage extends StatefulWidget {
  @override
  _CekOngkirPageState createState() => _CekOngkirPageState();
}

class _CekOngkirPageState extends State<CekOngkirPage> {
  GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  Future<bool> _onWillPop() async {
    return await openExitDialog(context) ?? false;
  }

  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Cek Ongkir"),
      ),
      body: _buildBody(),
    ), onWillPop: _onWillPop);
  }

  Widget _buildBody() {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        width: size.width,
        child: Column(
          children: [
            FirstPage(),
          ],
        ),
      ),
    );
  }
}
