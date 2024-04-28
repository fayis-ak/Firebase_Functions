import 'package:flutter/material.dart';

class customesnackbar {
  snackbar(BuildContext context,String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
