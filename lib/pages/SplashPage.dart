import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:winsome/pages/HomeScreen.dart';
import 'package:winsome/firebase_services/splash_services.dart';
import 'package:winsome/pages/phoneauth/PhoneVaification.dart';

class Splashpage extends StatefulWidget {
  const Splashpage({super.key});

  @override
  State<Splashpage> createState() => _SplashpageState();
}

class _SplashpageState extends State<Splashpage> {
  splash_services splashscreen = splash_services();
  @override
  void initState() {
    super.initState();
    splashscreen.IsLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 238, 229, 241),
        body: SingleChildScrollView(
          child: SafeArea(
              child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [Colors.white, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
            child: const Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 600),
                  child: Text(
                    "welcome to winsome ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 1),
                  child: Text("(version 1.0.0)",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.black26,
                      )),
                ),
              ],
            ),
          )),
        ));
  }
}
