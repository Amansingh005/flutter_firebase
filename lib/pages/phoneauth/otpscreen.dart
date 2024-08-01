import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:winsome/pages/HomeScreen.dart';
import 'package:winsome/utills/utills.dart';

class otpscreen extends StatefulWidget {
  final String verificationId;
  const otpscreen({super.key, required this.verificationId});

  @override
  State<otpscreen> createState() => _otpscreenState();
}

class _otpscreenState extends State<otpscreen> {
  final TextEditingController VerifyOtpController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            margin: const EdgeInsets.only(left: 25, right: 25),
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/otp.png',
                    height: 150,
                    width: 150,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text('Enter your otp '),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: VerifyOtpController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: "Enter the otp",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
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
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });

                          final credential = PhoneAuthProvider.credential(
                              verificationId: widget.verificationId,
                              smsCode: VerifyOtpController.text.toString());
                          try {
                            await _auth.signInWithCredential(credential);
                            Navigator.pushReplacement(
                                // ignore: use_build_context_synchronously
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen()));
                          } catch (e) {
                            setState(() {
                              loading = false;
                              utills.toastmessage(e.toString());
                            });
                          }
                        },
                        child: Center(
                            child: loading
                                ? const CircularProgressIndicator(
                                    strokeWidth: 4,
                                    color: Colors.white,
                                  )
                                : const Text("submit otp"))),
                  )
                ],
              ),
            )));
  }
}
