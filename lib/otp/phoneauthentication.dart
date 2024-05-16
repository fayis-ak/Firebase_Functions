// import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:pinput/pinput.dart';

// class Phoneauth {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<void> storenumber(String phoneno) async {
//     try {
//       await _firestore.collection('phoneauth').doc(phoneno).set({
//         'phonenumber': phoneno,
//       });
//     } catch (e) {
//       log('error$e');
//     }
//   }

//   Future<void> sendOtp(String phonenumber, Function(String) onCodeSend) async {
//     await _auth.verifyPhoneNumber(
//       timeout: Duration(seconds: 5),
//       phoneNumber: '+91$phonenumber',
//       verificationCompleted: (Credential) {},
//       verificationFailed: (error) {},
//       codeSent: (verificationId, forceResendingToken) {
//         onCodeSend(verificationId);
//       },
//       codeAutoRetrievalTimeout: (verificationId) {
        
//       },
//     );
//   }

//   // verify otp

//   Future<String> vrifyotp(
//       {required String vrifyId, required String otp}) async {
//     try {
//       final PhoneAuthCredential authCredential = PhoneAuthProvider.credential(
//         verificationId: vrifyId,
//         smsCode: otp,
//       );
//       final UserCredential userCredential =
//           await _auth.signInWithCredential(authCredential);

//       if (userCredential.user != null) {
//         await storenumber(userCredential.user!.phoneNumber!);
//         return 'success';
//       } else {
//         return 'error in otp';
//       }
//     } catch (e) {
//       return e.toString();
//     }
//   }
// }
