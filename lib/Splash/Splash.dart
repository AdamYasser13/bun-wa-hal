import 'dart:async';

import 'package:bun_wa_hal/auth/chose.dart';
import 'package:bun_wa_hal/main.dart';
import 'package:bun_wa_hal/style/styli.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

int logoTage = 1;

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

String email;
String password;
String phone;

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    getValiducation().whenComplete(
      () async {
        Timer(
          Duration(
            seconds: 4,
          ),
          () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => phone == null ? chose() : MyApp()));
          },
        );
      },
    );
  }

  DataConnectionStatus dataconnection;

  Future<bool> check() async {
    if (dataconnection == DataConnectionStatus.disconnected) {
      return Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => phone == null ? chose() : MyApp()));
    } else if (dataconnection == DataConnectionStatus.connected) {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
              "الرجاء التاكد من اتصال هاتفك و اعادة المحاولة لاحقا , شكرا"),
        ),
      );
    }
    return false;
  }

  Future getValiducation() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainEmail = sharedPreferences.getString('email');
    var obtainPassword = sharedPreferences.getString('password');
    var obtainPhone = sharedPreferences.getString('phone');
    setState(() {
      email = obtainEmail;
      password = obtainPassword;
      phone = obtainPhone;
    });
  }

  Widget build(BuildContext context) {
    return Container(
      color: Colora().white,
      child: Scaffold(
        body: Container(
          color: Colora().white,
          child: Center(
            child: Stack(
              children: [
                Hero(
                    tag: logoTage,
                    child: Lottie.asset('Images/desana', repeat: false)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
