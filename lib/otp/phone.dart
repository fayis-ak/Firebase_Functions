import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_fuctions/otp/otp.dart';
import 'package:firebase_fuctions/otp/phoneauthentication.dart';
import 'package:firebase_fuctions/screens/user_details.dart';
import 'package:firebase_fuctions/utils/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class PhoneAuth extends StatefulWidget {
  PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  final phoneController = TextEditingController();

  final key = GlobalKey<FormState>();

  Future<void> initiatePhoneVerification(BuildContext context) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '$selectedcountrycode${phoneController.text}',
        verificationCompleted: (PhoneAuthCredential credential) {
          // This callback will be invoked in case of instant verification.
          // You can directly sign in the user here.
          signInWithPhoneCredential(context, credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          // Handle verification failure
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Verification failed: ${e.message}'),
            ),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          // Navigate to OTP screen after code is sent
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OtpScreen(
                    verificationid: verificationId,
                    mobilenumber:
                        '$selectedcountrycode${phoneController.text}')),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Handle timeout
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    }
  }

// Function to sign in with phone credential
  Future<void> signInWithPhoneCredential(
      BuildContext context, PhoneAuthCredential credential) async {
    try {
      final authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      // Check if the user is signed in
      if (authResult.user != null) {
        // User signed in successfully, navigate to the next screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => UserDetails(),
          ),
        );
      } else {
        // Handle sign in failure
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sign in failed'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    }
  }

  final selectedcountrycode = '+91';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: key,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: ResponsiveHelper.getHeight(context) * .200,
              ),
              TextFormField(
                keyboardType: TextInputType.phone,
                controller: phoneController,
                decoration: InputDecoration(
                  hintText: 'phone number',
                  border: OutlineInputBorder(),
                ),
                autofillHints: [AutofillHints.oneTimeCode],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter value';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: ResponsiveHelper.getHeight(context) * .100,
              ),
              GestureDetector(
                onTap: () async {
                  if (key.currentState!.validate()) {
                    // try {
                    //   await FirebaseAuth.instance.verifyPhoneNumber(
                    //     phoneNumber:
                    //         '${selectedcountrycode + phoneController.text}',
                    //     verificationCompleted:
                    //         (PhoneAuthCredential credential) {},
                    //     verificationFailed: (FirebaseAuthException e) {},
                    //     codeSent: (String verificationId, int? resendToken) {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //             builder: (context) => OtpScreen(
                    //               verificationid: verificationId,
                    //               mobilenumber:
                    //                   '$selectedcountrycode${phoneController.text}',
                    //             ),
                    //           ));
                    //       log('the phone credial block enter ');
                    //     },
                    //     codeAutoRetrievalTimeout: (String verificationId) {},
                    //   );
                    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //       duration: Duration(seconds: 2),
                    //       content: Text('otp send succes')));
                    // } catch (e) {
                    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //       duration: Duration(seconds: 3),
                    //       content: Text('error$e')));

                    //   log('errro $e');
                    // }
                    await initiatePhoneVerification(context);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 200,
                  height: 70,
                  color: Colors.amber,
                  child: Text('Send otp'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
