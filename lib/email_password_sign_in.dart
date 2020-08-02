import 'package:avmv005/Model/user_model.dart';
import 'package:avmv005/View_Model/user_model.dart';
import 'package:avmv005/widgets/common_widget/social_login_button.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

enum FormType { Register, Login }

class EmailPasswordSignIn extends StatefulWidget {
  @override
  _EmailPasswordSignInState createState() => _EmailPasswordSignInState();
}

class _EmailPasswordSignInState extends State<EmailPasswordSignIn> {
  String _email, _sifre;
  String _buttonText, _linkText;
  var _formType = FormType.Login;

  final _formKey = GlobalKey<FormState>();

  void _formSubmit() async {
    _formKey.currentState.save();
    final _userModel = Provider.of<UserModel>(context);
    if (_formType == FormType.Login) {
      User _girisYapanUser =
          await _userModel.signInWithEmailPassword(_email, _sifre);
      print(_girisYapanUser.toString());
    } else {
      User _olusturulanUser =
          await _userModel.createUserWithEmailPassword(_email, _sifre);
      print(_olusturulanUser.toString());
    }
  }

  void _degistir() {
    setState(() {
      _formType =
          _formType == FormType.Login ? FormType.Register : FormType.Login;
    });
  }

  @override
  Widget build(BuildContext context) {
    _buttonText = _formType == FormType.Login ? "Giriş Yap" : "Kayıt Ol";
    _linkText = _formType == FormType.Login
        ? "Hesabınız Yok Mu ? Kayıt Olun"
        : "Hesabınız Var Mı ? Giriş Yapın";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Giriş/Kayıt"),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.mail),
                  hintText: "Email",
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                onSaved: (String email) {
                  _email = email;
                },
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.mail),
                  hintText: "Şifre",
                  labelText: "Şifre",
                  border: OutlineInputBorder(),
                ),
                onSaved: (String sifre) {
                  _sifre = sifre;
                },
              ),
              SizedBox(
                height: 8,
              ),
              SocialLoginButton(
                textColor: Colors.white,
                buttonText: _buttonText,
                buttonColor: Colors.deepPurple,
                onPressed: () => _formSubmit(),
                radius: 12.0,
              ),
              SizedBox(
                height: 10,
              ),
              FlatButton(
                onPressed: () => _degistir(),
                child: Text(_linkText),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
