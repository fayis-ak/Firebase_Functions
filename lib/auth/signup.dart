import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_fuctions/firebase/adduser.dart';
import 'package:firebase_fuctions/screens/user_details.dart';
import 'package:firebase_fuctions/utils/container.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:firebase_fuctions/utils/responsive.dart';
import 'package:firebase_fuctions/utils/textform.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool isloading = false;

  String email = "", password = "";

  final _authentication = FirebaseAuth.instance;

  regitration() async {
    if (password != null) {
      try {
        setState(() {
          isloading = true;
        });
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registrations succes'),
          ),
        );
        String id = randomString(10);
        Map<String, dynamic> empoyementInfoMap = {
          "Name": emailController.text,
          'uid': _authentication.currentUser!.uid,
          // 'imageurl': imageUrl
        };
        await firebase().addusersignup(empoyementInfoMap, id);
        const snackBar = SnackBar(
          content: Text('create user'),
        );
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => UserDetails(),
            ));
        setState(() {
          isloading = false;
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          setState(() {
            isloading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(' weak password'),
            ),
          );
        } else if (e.code == 'email-already-in-use') {
          setState(() {
            isloading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('email already use'),
            ),
          );
        }
      }
    }
  }

  String imageUrl = '';
  var profileImage;
  XFile? pickedFile;
  File? image;

  Future<void> uploadImage() async {
    try {
      if (profileImage != null) {
        Reference referenceRoot = FirebaseStorage.instance.ref();
        Reference referenceDreImage = referenceRoot.child('image');

        // Upload image to Firebase Storage
        UploadTask uploadTask = referenceDreImage.putFile(profileImage);

        // Wait for the upload to complete
        TaskSnapshot taskSnapshot = await uploadTask;

        // Get download URL
        imageUrl = await taskSnapshot.ref.getDownloadURL();

        print(
            '------------------$imageUrl========================================');

        // Reference storageReference =
        //     FirebaseStorage.instance.ref().child('image/${pickedFile!.name}');

        // await storageReference.putFile(profileImage!);
        // imageUrl = await storageReference.getDownloadURL();
      }
    } catch (e) {
      print('error upload image $e');
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
                  height: ResponsiveHelper.getHeight(context) * .080,
                ),
                Container(
                  // color: Colors.red,
                  height: ResponsiveHelper.getHeight(context) * .250,
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                              radius: ResponsiveHelper.getWidth(context) * .130,
                              backgroundImage: profileImage != null
                                  ? FileImage(profileImage)
                                  : null,
                              child: profileImage == null
                                  ? Icon(Icons.error)
                                  : null),
                        ],
                      ),
                      Positioned(
                          left: ResponsiveHelper.getWidth(context) * .50,
                          top: ResponsiveHelper.getHeight(context) * .080,
                          child: GestureDetector(
                            onTap: () async {
                              ImagePicker picker = ImagePicker();
                              pickedFile = await picker.pickImage(
                                  source: ImageSource.gallery);

                              setState(() {
                                if (pickedFile != null) {
                                  profileImage = File(pickedFile!.path);
                                }
                              });
                            },
                            child: CircleAvatar(
                              radius: ResponsiveHelper.getWidth(context) * .050,
                              backgroundColor: Colors.grey,
                              child: Icon(Icons.camera_alt_outlined),
                            ),
                          ))
                    ],
                  ),
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
                    Text('abcd@gmail.com'),
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
                    Text('username'),
                  ],
                ),
                SizedBox(
                  height: ResponsiveHelper.getHeight(context) * .030,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('conformpassword'),
                  ],
                ),
                SizedBox(
                  height: ResponsiveHelper.getHeight(context) * .120,
                ),
                GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        email = emailController.text;
                        password = passwordController.text;
                      });
                      if (profileImage == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('please add profel')));
                      }
                      await uploadImage();
                      regitration();
                    }
                  },
                  child: isloading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ContainerWidget(
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
