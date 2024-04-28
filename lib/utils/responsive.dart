import 'package:flutter/material.dart';

class ResponsiveHelper {
  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getScreenRatio(BuildContext context) {
    return getWidth(context) / getHeight(context);
  }
}
