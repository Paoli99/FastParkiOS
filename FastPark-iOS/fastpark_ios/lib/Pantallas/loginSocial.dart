import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:provider/provider.dart';
import 'package:pruebaflutter/logica/autenticacion.dart';

import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  StreamSubscription<FirebaseUser> estadoLogin;

  @override
  void initState() {
    var facebookAuth = Provider.of<Autenticacion>(context, listen: false);
    estadoLogin = facebookAuth.currentUser.listen((usuariofb) {
      if (usuariofb != null) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    estadoLogin.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var facebookAuth = Provider.of<Autenticacion>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SignInButton(Buttons.Facebook,
                onPressed: () => facebookAuth.loginFacebook())
          ],
        ),
      ),
    );
  }
}
