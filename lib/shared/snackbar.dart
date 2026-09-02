import 'package:flower_app/shared/constants.dart';
import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String text, int seconds) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      behavior: SnackBarBehavior.fixed,
      showCloseIcon: true,
      padding: const EdgeInsets.all(3),
      backgroundColor: appBarGreen,
      closeIconColor: Colors.white,
      duration: Duration(seconds: seconds),
      content: Center(
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),
    ),
  );
}
