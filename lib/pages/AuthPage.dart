// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import "package:abnews/pages/auth/LoginPage.dart";
import "package:abnews/pages/auth/RegisterPage.dart";
import "package:flutter/material.dart";

class AuthPage extends StatefulWidget {

  const AuthPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  var pageIs = 'Login';

  @override
  Widget build(BuildContext context) {
      Widget page;

      switch (pageIs) {
        case 'Login':
          page = LoginPage();
          break;
        case 'Register':
          page = RegisterPage();
          break;
        default:
          page = LoginPage();
          break;
      }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            page,
          ],
        ),
      ),
    );
  }
}
