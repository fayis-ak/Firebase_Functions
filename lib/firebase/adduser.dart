import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class firebase {
  final _auth = FirebaseFirestore.instance;

  final _authentication = FirebaseAuth.instance;

// add user
  Future addtodo(
    Map<String, dynamic> employeInfoMap,
  ) async {
    String userId = _authentication.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection('todo')
        .doc()
        .set({...employeInfoMap, 'userId': userId});
  }

  // user
  Future addusersignup(
      Map<String, dynamic> employeInfoMap, String userid) async {
    return FirebaseFirestore.instance
        .collection('cutomers')
        .doc(userid)
        .set(employeInfoMap);
  }

  // fetch
  Future<Stream<QuerySnapshot>> getuser() async {
    String userId = _authentication.currentUser!.uid;
    return await _auth
        .collection('todo')
        .where('userId', isEqualTo: userId)
        .snapshots();
  }

  //update
  Future updatetodo(String id, Map<String, dynamic> updateInfo) async {
    try {
      await FirebaseFirestore.instance
          .collection('todo')
          .doc(id)
          .update(updateInfo);
      log('===================================update succes succes==========================================================');
    } catch (e) {
      print('error update $e===========');
    }
  }

  

  Future<void> delete(String id) async {
    try {
      await FirebaseFirestore.instance.collection("todo").doc(id).delete();
      print("Document deleted");
    } catch (e) {
      print("Error deleting document: $e");
    }
  }
}
