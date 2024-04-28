import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class CustomToast {
  static void showSuccessToast(String message, {int duration = 2}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 16.0,
      timeInSecForIosWeb: duration,
    );
  }

  static void showErrorToast(String message, {int duration = 2}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.blue, // Customize the background color here
      textColor: Colors.white,
      fontSize: 16.0, // You can adjust the font size
      timeInSecForIosWeb: duration,
    );
  }
}
