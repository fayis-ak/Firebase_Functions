import 'package:flutter/material.dart';
 
class ContainerWidget extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final String text;
  final double? textsize;
  const ContainerWidget(
      {super.key,
      required this.width,
      required this.height,
      required this.text,
      required this.radius,
      this.textsize});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(radius)),
      child: Center(
        child: Text(
          text,
           
        ),
      ),
    );
  }
}
