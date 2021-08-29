import 'package:flutter/material.dart';
import 'package:get/get.dart';

void customSnackBar(String title, String text,
    {IconData icon: Icons.error, Color color: Colors.red, Function onTap}) {
  if (onTap == null) {
    onTap = (snack) {};
  }
  Get.snackbar(
    title,
    text,
    duration: new Duration(seconds: 3),
    icon: Icon(
      icon,
      color: color,
    ),
    backgroundColor: Colors.white,
    onTap: onTap,
  );
}
