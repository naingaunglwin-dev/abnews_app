// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:abnews/utility/AlertBox.dart';
import 'package:flutter/material.dart';

class Validate {
  final String on;
  String? username;
  String? password;
  String? confirmPassword;

  Validate({
    required this.on,
    this.username,
    this.password,
    this.confirmPassword
  });

  validation(BuildContext context)
  {
    switch (on) {
      case 'login':
        if (username == null || username!.isEmpty) {
          CustomAlertBox(context, "Error", "Username can't be empty", null);
          return false;
        }

        if (password == null || password!.isEmpty) {
          CustomAlertBox(context, "Error", "Password can't be empty", null);
          return false;
        }

        return true;
      case 'register':
        if (username == null || username!.isEmpty) {
          CustomAlertBox(context, "Error", "Username can't be empty", null);
          return false;
        }

        if (password == null || password!.isEmpty) {
          CustomAlertBox(context, "Error", "Password can't be empty", null);
          return false;
        }

        if (confirmPassword == null || confirmPassword!.isEmpty) {
          CustomAlertBox(context, "Error", "Confirm Password can't be empty", null);
          return false;
        }

        return true;
      default:
        return true;
    }
  }
}
