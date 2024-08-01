import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:winsome/pages/phoneauth/LoginPage.dart';
import 'package:winsome/utills/utills.dart';

class signupscreen extends StatefulWidget {
  const signupscreen({super.key});

  @override
  State<signupscreen> createState() => _signupscreenState();
}

class _signupscreenState extends State<signupscreen> {
  final TextEditingController emailcontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();
  bool loading = false;
  final TextEditingController passwordcontroller = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void login() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 70),
                child: Center(
                    child: Text(
                  "sign up page",
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
                      const SizedBox(height: 30),
                      SizedBox(
                        height: 60,
                        width: 320,
                        child: TextFormField(
                          controller: passwordcontroller,
                          obscureText: true,
                          decoration: const InputDecoration(
                              hintText: 'confirm your password',
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
                      )
                    ],
                  )),
              const SizedBox(
                height: 25,
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
                      setState(() {
                        loading = true;
                      });
                      _auth
                          .createUserWithEmailAndPassword(
                              email: emailcontroller.text.toString(),
                              password: passwordcontroller.text.toString())
                          .then((value) {
                        setState(() {
                          loading = false;
                        });
                      }).onError((error, stacktrace) {
                        setState(() {
                          loading = false;
                        });
                        utills.toastmessage(error.toString());
                      });
                    },
                    child: Center(
                      child: loading
                          ? const CircularProgressIndicator(
                              strokeWidth: 3,
                              color: Colors.white,
                            )
                          : const Text(
                              'sign up',
                              style: TextStyle(fontSize: 10),
                            ),
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("if you have already account ?"),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Loginpage()));
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 17),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
