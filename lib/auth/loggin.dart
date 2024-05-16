import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_fuctions/admin/adminhome.dart';
import 'package:firebase_fuctions/firebase/adduser.dart';
import 'package:firebase_fuctions/google/googel_home.dart';
import 'package:firebase_fuctions/imagestorefirebase/image.dart';
import 'package:firebase_fuctions/otp/phone.dart';
import 'package:firebase_fuctions/auth/signup.dart';
import 'package:firebase_fuctions/screens/user_details.dart';

import 'package:firebase_fuctions/utils/responsive.dart';
import 'package:firebase_fuctions/utils/textform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../utils/container.dart';

class LogginScreen extends StatefulWidget {
  LogginScreen({super.key});

  @override
  State<LogginScreen> createState() => _LogginScreenState();
}

class _LogginScreenState extends State<LogginScreen> {
  final _auth = FirebaseAuth.instance;

  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    String email = "", password = "";

    userLogin() async {
      if (emailController.text == 'admin@gmail.com' &&
          passwordController.text == 'admin123') {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return AdminHome();
        }));
      }
      try {
        setState(() {
          isloading = true;
        });
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserDetails(),
            ));
        setState(() {
          isloading = false;
        });
      } on FirebaseException catch (e) {
        setState(() {
          isloading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('somethig fishy!!!!!'),
          ),
        );
        if (e.code == 'user-not-found') {
          print(
              '------------------------errorr==============================$e');
          setState(() {
            isloading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('no user found register  '),
            ),
          );
        } else if (e.code == 'wrong-password') {
          setState(() {
            isloading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('wrong password provided by user'),
            ),
          );
        }
      }
    }

    signinwithgoogle() async {
      try {
        final GoogleSignInAccount? goggleUser = await GoogleSignIn().signIn();

        final GoogleSignInAuthentication? googleAuth =
            await goggleUser?.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        // log('goggle user name ${userCredential.user?.displayName}');

        if (userCredential.user != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GoggleHomeScren(),
              ));
        }
      } on FirebaseException catch (e) {
        log('goggle error $e');
      }
    }

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveHelper.getWidth(context) * .080,
            // vertical: ResponsiveHelper.getHeight(context) * .080,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: ResponsiveHelper.getHeight(context) * .040,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ResponsiveHelper.getHeight(context) * .080,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('username'),
                      Textformwidget(
                        type: TextInputType.emailAddress,
                        controller: emailController,
                        hint: 'email',
                        radius: ResponsiveHelper.getWidth(context) * .080,
                        validation: (value) {
                          if (value == null || value.isEmpty) {
                            return 'pleae enter a value';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ResponsiveHelper.getHeight(context) * .050,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('password'),
                      Textformwidget(
                        controller: passwordController,
                        hint: 'password',
                        radius: ResponsiveHelper.getWidth(context) * .080,
                        validation: (value) {
                          if (value == null || value.isEmpty) {
                            return 'pleae enter a value';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ResponsiveHelper.getHeight(context) * .020,
                  ),
                  Row(
                    children: [
                      Text('forgot password'),
                    ],
                  ),
                  SizedBox(
                    height: ResponsiveHelper.getHeight(context) * .080,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          email = emailController.text;
                          password = passwordController.text;
                        });
                        userLogin();
                      }
                    },
                    child: isloading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ContainerWidget(
                            width: ResponsiveHelper.getWidth(context) * .600,
                            height: ResponsiveHelper.getHeight(context) * .070,
                            text: 'Login',
                            radius: ResponsiveHelper.getWidth(context) * .050,
                          ),
                  ),
                  SizedBox(
                    height: ResponsiveHelper.getHeight(context) * .030,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: ResponsiveHelper.getWidth(context) * .030,
                        child: Divider(),
                      ),
                      Text('or'),
                      SizedBox(
                        width: ResponsiveHelper.getWidth(context) * .030,
                        child: Divider(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ResponsiveHelper.getHeight(context) * .040,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(
                      //   builder: (context) {
                      //     return PhoneAuth();
                      //   },
                      // ));
                    },
                    child: Container(
                      width: ResponsiveHelper.getWidth(context) * .800,
                      height: ResponsiveHelper.getHeight(context) * .080,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          ResponsiveHelper.getWidth(context) * .020,
                        ),
                        border: Border.all(color: Colors.blue),
                      ),
                      child: Row(
                        children: [
                          // Icon(Icons.goggle),
                          SizedBox(
                            width: ResponsiveHelper.getWidth(context) * .080,
                          ),
                          SizedBox(
                            width: ResponsiveHelper.getWidth(context) * .010,
                          ),
                          InkWell(
                              onTap: () async {
                                await signinwithgoogle();
                              },
                              child: Text('Continue with google'))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ResponsiveHelper.getHeight(context) * .040,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('cretae account'),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignupScreen(),
                                ));
                          },
                          child: Text(
                            'signin',
                            style: TextStyle(color: Colors.blue),
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PhoneAuth(),
                                ));
                          },
                          child: Text('[phone]')),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ImageStore(),
                                ));
                          },
                          child: Text('image store')),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}












// onTap: () async {
                    //   if (formKey.currentState!.validate()) {
                    //     final email = emailController.text;
                    //     final password = passwordController.text;
                    //     try {
                    //       await firebase().signin(email, password);
                    //       log('Loggin succes ful');
                    //       Fluttertoast.showToast(
                    //           msg: "loggin succes ful",
                    //           toastLength: Toast.LENGTH_SHORT,
                    //           gravity: ToastGravity.CENTER,
                    //           timeInSecForIosWeb: 1,
                    //           backgroundColor: Colors.red,
                    //           textColor: Colors.white,
                    //           fontSize: 16.0);
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //             builder: (context) => UserDetails(),
                    //           ));
                    //     } catch (e) {
                    //       log('error $e');
                    //     }
                    //   }

                    // },