import 'package:firebase_fuctions/utils/responsive.dart';
import 'package:flutter/material.dart';

class Textformwidget extends StatelessWidget {
  final String hint;
  final double radius;
  final TextEditingController controller;
  final FormFieldValidator<String>? validation;
  final TextInputType? type;
  const Textformwidget(
      {super.key,
      required this.hint,
      required this.radius,
      required this.controller,
      required this.validation, this.type});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: type,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      decoration: InputDecoration(
        
        contentPadding: EdgeInsets.all(
          ResponsiveHelper.getWidth(context) * .010,
        ),
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(ResponsiveHelper.getWidth(context) * .020),
          borderSide: BorderSide(
            color: Colors.blue,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(ResponsiveHelper.getWidth(context) * .020),
          borderSide: BorderSide(
            color: Colors.blue,
            width: 1.0,
          ),
        ),
      ),
      validator: validation,
    );
  }
}
