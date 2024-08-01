import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:winsome/pages/phoneauth/otpscreen.dart';
import 'package:winsome/utills/utills.dart';

class PhoneVarification extends StatefulWidget {
  const PhoneVarification({super.key});

  @override
  State<PhoneVarification> createState() => _PhoneVarificationState();
}

class _PhoneVarificationState extends State<PhoneVarification> {
  final TextEditingController PhonController = TextEditingController();
  bool loading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void login() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 229, 241),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/file.png',
                width: 150,
                height: 150,
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "We need to register your phone without getting started!",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: PhonController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Phone Number",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                ),
              ),
              const SizedBox(
                height: 20,
                width: 100,
              ),
              SizedBox(
                width: 320,
                height: 60,
                child: ElevatedButton(
                    style: ButtonStyle(
                      foregroundColor:
                          WidgetStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          WidgetStateProperty.all<Color>(Colors.purple),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      _auth.verifyPhoneNumber(
                          phoneNumber: PhonController.text,
                          verificationCompleted: (_) {
                            setState(() {
                              loading = false;
                            });
                          },
                          verificationFailed: (e) {
                            utills.toastmessage(e.toString());
                            setState(() {
                              loading = false;
                            });
                          },
                          codeSent: (String verificationId, int? tokenId) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => otpscreen(
                                        verificationId: verificationId)));
                            setState(() {
                              loading = false;
                            });
                          },
                          codeAutoRetrievalTimeout: (e) {
                            utills.toastmessage(e.toString());
                            setState(() {
                              loading = false;
                            });
                          });
                    },
                    child: Center(
                        child: loading
                            ? const CircularProgressIndicator(
                                strokeWidth: 4,
                                color: Colors.white,
                              )
                            : const Text("Send the code"))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
