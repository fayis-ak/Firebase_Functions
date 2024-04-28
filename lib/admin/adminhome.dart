import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Welcome admin',
        style: TextStyle(color: Colors.grey, fontSize: 20),
      ),
    );
  }
}
