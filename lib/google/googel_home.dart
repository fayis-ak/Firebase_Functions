import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_fuctions/auth/loggin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoggleHomeScren extends StatelessWidget {
  const GoggleHomeScren({super.key});

  @override
  Widget build(BuildContext context) {
    // ValueNotifier userCredential = ValueNotifier('');
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final _auth = FirebaseAuth.instance;

    Future googlelogout() async {
      try {
        await googleSignIn.signOut().then((value) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => LogginScreen(),
              ),
              (route) => false);
          Fluttertoast.showToast(
              msg: "logout google succes",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        });
        // await _auth.signOut();
        log('curent user google ac logout suc ${googleSignIn.currentUser!.email}');
      } on FirebaseException catch (e) {
        log('error $e');
      }
    }

    getProfileImage() {
      if (_auth.currentUser!.photoURL != null) {
        return Image.network(_auth.currentUser!.photoURL.toString());
      } else {
        return Icon(Icons.camera);
      }
    }

    imagelognpress() {
      showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return Container(
            width: 200,
            height: 200,
            child: getProfileImage(),
          );
        },
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            FirebaseAuth.instance.currentUser != null
                ? FirebaseAuth.instance.currentUser!.email ?? 'loading'
                : 'No user logged in',
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await googlelogout();

                log('curent user google logout ');
              },
            )
          ],
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onLongPress: () {
                    imagelognpress();
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 1.5, color: Colors.black54)),
                    child: getProfileImage(),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(_auth.currentUser!.displayName.toString()),
            SizedBox(
              height: 20,
            ),
            Text(_auth.currentUser!.email.toString()),
            SizedBox(
              height: 20,
            ),
          ],
        ));
  }
}
