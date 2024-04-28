import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_fuctions/firebase/adduser.dart';
import 'package:firebase_fuctions/screens/user_details.dart';
import 'package:firebase_fuctions/utils/container.dart';

import 'package:flutter/material.dart';
import 'package:firebase_fuctions/utils/responsive.dart';
import 'package:firebase_fuctions/utils/textform.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/widgets.dart';
import 'package:random_string/random_string.dart';

class FirebaseCheck extends StatefulWidget {
  FirebaseCheck({super.key});

  @override
  State<FirebaseCheck> createState() => _FirebaseCheckState();
}

class _FirebaseCheckState extends State<FirebaseCheck> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController age = TextEditingController();

  TextEditingController details = TextEditingController();

  bool isloading = false;

  String email = "", password = "";

  Future addfirebase(Map<String, dynamic> employeInfoMap, String userid) async {
    return FirebaseFirestore.instance
        .collection('firebase')
        .doc(userid)
        .set(employeInfoMap);
  }

  regitration() async {
    if (password != null) {
      try {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registrations succes'),
          ),
        );
        String id = randomString(10);
        Map<String, dynamic> empoyementInfoMap = {
          "Name": emailController.text,
          "email": passwordController.text,
          'age': age.text,
          'detials': details.text,
          "id": id,
        };
        await addfirebase(empoyementInfoMap, id);
        const snackBar = SnackBar(
          content: Text('add sucs firebase'),
        );
      } on FirebaseAuthException catch (e) {
        log('error $e');
        SnackBar(
          content: Text('error ${e.toString()}'),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.getWidth(context) * .080,
          // vertical: ResponsiveHelper.getHeight(context) * .080,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: ResponsiveHelper.getHeight(context) * .040,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [],
                ),
                SizedBox(
                  height: ResponsiveHelper.getHeight(context) * .080,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('username'),
                    Container(
                      child: Textformwidget(
                        type: TextInputType.emailAddress,
                        controller: emailController,
                        hint: 'emial',
                        radius: ResponsiveHelper.getWidth(context) * .080,
                        validation: (value) {
                          if (value == null || value.isEmpty) {
                            return 'pleae enter a value';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: ResponsiveHelper.getHeight(context) * .030,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('email'),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('age'),
                    Textformwidget(
                      controller: age,
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
                  height: ResponsiveHelper.getHeight(context) * .120,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('details'),
                    Textformwidget(
                      controller: details,
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
                  height: ResponsiveHelper.getHeight(context) * .120,
                ),
                GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      regitration();
                    }
                  },
                  child: ContainerWidget(
                    width: ResponsiveHelper.getWidth(context) * .600,
                    height: ResponsiveHelper.getHeight(context) * .070,
                    text: 'Sign up',
                    radius: ResponsiveHelper.getWidth(context) * .050,
                  ),
                ),
                SizedBox(
                  height: ResponsiveHelper.getHeight(context) * .030,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
