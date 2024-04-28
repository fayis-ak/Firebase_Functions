import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_fuctions/otp/phoneauthentication.dart';
import 'package:firebase_fuctions/screens/user_details.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatelessWidget {
  final String verificationid;
  final String mobilenumber;
  OtpScreen({
    super.key,
    required this.verificationid,
    required this.mobilenumber,
  });
  final _formState = GlobalKey<FormState>();
  final otpController = TextEditingController();

   
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formState,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "OTP Verification",
                style: TextStyle(
                    color: const Color.fromARGB(255, 63, 69, 104),
                    fontSize: 27,
                    fontWeight: FontWeight.w500),
              ),
              Divider(
                indent: 30,
                endIndent: 30,
                thickness: 2,
                color: const Color.fromARGB(110, 100, 100, 100),
              ),
              const Text("""Enter the verification code that
              we just send you!"""),
              SizedBox(
                height: 50,
              ),
              Pinput(
                length: 6,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "enter otp";
                  } else {
                    return null;
                  }
                },
                controller: otpController,
                defaultPinTheme: PinTheme(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(
                          width: 3,
                          style: BorderStyle.solid,
                          color: const Color.fromARGB(255, 63, 69, 104),
                        )
                        // border: Border.all(),
                        )),
                // preFilledWidget: SizedBox(
                //   height: 4.5.h,
                //   width: 10.w,
                // ),
                // border: Border.all(),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: 100,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        backgroundColor: const Color.fromARGB(255, 255, 0, 0)),
                    onPressed: () async {
                      if (_formState.currentState!.validate()) {
                        // verifyotp(context);
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: verificationid,
                                smsCode: otpController.text);

                        // Sign the user in (or link) with the credential
                        await auth.signInWithCredential(credential);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserDetails(),
                            ));
                      }
                    },
                    child: Text(
                      "Submit",
                    )),
              ),
              Text(
                "Resend OTP",
              )
            ],
          ),
        ),
      ),
    );
  }
}
