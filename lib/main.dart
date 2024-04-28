import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_fuctions/auth/loggin.dart';
import 'package:firebase_fuctions/auth/signup.dart';
import 'package:firebase_fuctions/busines_logic/firebase_options.dart';
import 'package:firebase_fuctions/firebasecheck.dart';
import 'package:firebase_fuctions/otp/otp.dart';
import 'package:firebase_fuctions/otp/phone.dart';
import 'package:firebase_fuctions/screens/user_details.dart';
import 'package:firebase_fuctions/screens/useradd.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LogginScreen(),
      // home: PhoneAuth(),
    );
  }
}
