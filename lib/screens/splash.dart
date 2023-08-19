import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/screens/homePage.dart';
import 'package:task_manager/screens/login.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

bool isLogin = false;

class _SplashState extends State<Splash> {
  Future sharedPreferencesIntialize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLogin = prefs.getBool('isLogin') ?? false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    sharedPreferencesIntialize().whenComplete(() {
      Timer(Duration(seconds: 2), () {
        isLogin
            ? Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
                (route) => false,
              )
            : Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Login()),
                (route) => false,
              );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade100,
      body: Padding(
        padding: const EdgeInsets.only(left: 50),
        child: Center(
          child: Lottie.asset('assets/lottie/ani.json'),
        ),
      ),
    );
  }
}
