import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:winsome/pages/HomeScreen.dart';
import 'package:winsome/pages/phoneauth/PhoneVaification.dart';
import 'package:winsome/pages/phoneauth/otpscreen.dart';
import 'package:winsome/pages/phoneauth/signupscreen.dart';
import 'package:winsome/utills/utills.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  bool loading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  void login() {
    setState(() {
      loading = true;
    });

    _auth
        .signInWithEmailAndPassword(
      email: emailcontroller.text,
      password: passwordcontroller.text.toString(),
    )
        .then((value) {
      utills.toastmessage(value.user!.email.toString());
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      utills.toastmessage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // onPopInvoked:  (name)  => false,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 238, 229, 241),
        body: Center(
            child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 70),
                child: Center(
                    child: Text(
                  "Login page!",
                  style: TextStyle(fontSize: 30),
                )),
              ),
              const SizedBox(
                height: 90,
                width: double.infinity,
              ),
              Form(
                  key: formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 60,
                        width: 320,
                        child: TextFormField(
                          controller: emailcontroller,
                          decoration: const InputDecoration(
                              hintText: 'email',
                              suffixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)))),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter email';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                        width: double.infinity,
                      ),
                      SizedBox(
                        height: 60,
                        width: 320,
                        child: TextFormField(
                          controller: passwordcontroller,
                          obscureText: true,
                          decoration: const InputDecoration(
                              hintText: 'password',
                              suffixIcon: Icon(Icons.password),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)))),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter password';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 50,
                width: 320,
                child: ElevatedButton(
                    style: ButtonStyle(
                      foregroundColor:
                          WidgetStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          WidgetStateProperty.all<Color>(Colors.purple),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (formkey.currentState!.validate()) {}
                      login();
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const HomeScreen()));
                    },
                    child: Center(
                      child: loading
                          ? const CircularProgressIndicator(
                              strokeWidth: 3,
                              color: Colors.white,
                            )
                          : const Text(
                              'login',
                              style: TextStyle(fontSize: 10),
                            ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: const Text('Forget password?')),
                    // const SizedBox(
                    //   width: 3,
                    // ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const signupscreen()));
                        },
                        child: const Text('Signup'))
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PhoneVarification()));
                },
                child: Container(
                  height: 50,
                  width: 320,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                      border: Border.all(color: Colors.black)),
                  child: const Text("login with phone "),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
