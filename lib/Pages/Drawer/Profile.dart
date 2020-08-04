import 'package:avmv005/Model/user_model.dart';
import 'package:avmv005/Utils/database_helper.dart';
import 'package:avmv005/View_Model/user_model.dart';
import 'package:avmv005/main.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  final User user;
  DatabaseHelper dbh1 = DatabaseHelper();

  ProfilePage({Key key, @required this.user}) : super(key: key);
  DatabaseHelper dbh2 = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    dbdenVerileriGetir();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(80, 77, 229, 100),
        actions: <Widget>[
          FlatButton(
            onPressed: () => _cikisYap(context),
            child: Text(
              "Çıkış Yap",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        )),
        title: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(73, 70, 218, 100),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
      drawer: DrawerCodeOnly(),
      body: SafeArea(
        child: ListView(
          children: <Widget>[],
        ),
      ),
    );
  }

  void dbdenVerileriGetir() async {
    var result = await dbh2.allFavorites();
    print(result.toString());
  }

  Future<bool> _cikisYap(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context);
    bool result = await _userModel.signOut();
    return result;
  }
}
