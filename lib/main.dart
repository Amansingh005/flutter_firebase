import 'package:flutter/material.dart';
import 'package:winsome/pages/HomeScreen.dart';
import 'package:winsome/pages/phoneauth/LoginPage.dart';
import 'package:winsome/pages/SplashPage.dart';
// import 'package:winsome/pages/LoginPage.dart';
// import 'package:winsome/pages/SplashPage.dart';
import 'package:winsome/pages/phoneauth/PhoneVaification.dart';
// import 'package:winsome/pages/phoneauth/otpscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:winsome/pages/phoneauth/otpscreen.dart';
import 'package:winsome/pages/phoneauth/signupscreen.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAj-FftKXnDTeg4JEI-w-VcK-L35JfvLWY",
          appId: "1:795089266069:android:72d5e0a50329d87fcf429c",
          messagingSenderId: "795089266069",
          projectId: "winesome-1004b"));

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: const HomeScreen()
        /* initialRoute: '/',
      routes: {
        '/': (context) => const Splashpage(),
        '/login': (context) => const PhoneVarification()
      },*/
        );
  }
}
