// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:abnews/pages/auth/LoginPage.dart';
import 'package:abnews/utility/AlertBox.dart';
import 'package:abnews/utility/Validate.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late Widget page;

  @override
  void initState() {
    super.initState();
    page = Form(navigateToLogin:  _navigateToLogin);
  }

  @override
  Widget build(BuildContext context) {
    return page;
  }

  void _navigateToLogin()
  {
    setState(() {
      page = LoginPage();
    });
  }
}

class Form extends StatelessWidget {
  final navigateToLogin;

  const Form({
    Key? key,
    required this.navigateToLogin
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _cpasswordController = TextEditingController();

    void register() async {
      var username  = _usernameController.text;
      var password   = _passwordController.text;
      var cpassword = _cpasswordController.text;

      var validate = Validate(on: 'register', username: username, password: password, confirmPassword: cpassword);

      if (validate.validation(context)) {
        showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        );

        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: username,
            password: password
          );

          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }

          navigateToLogin();
        } on FirebaseAuthException catch (e) {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }

          CustomAlertBox(context, 'Authentication Error', e.code, null);
        }
      }
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      child: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Register',
              style: TextStyle(
                color: Colors.white,
                fontSize: 21
              ),
            ), 
        
            SizedBox(
              height: 45,
            ),
        
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                hintText: 'Email',
                hintStyle: TextStyle(color: Colors.white70)
              ),
              style: TextStyle(color: Colors.white),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.white70)
              ),
              style: TextStyle(color: Colors.white),
            ),
            TextField(
              controller: _cpasswordController,
              decoration: InputDecoration(
                hintText: 'Comfirm Password',
                hintStyle: TextStyle(color: Colors.white70)
              ),
              style: TextStyle(color: Colors.white),
            ),
        
            SizedBox(
              height: 20,
            ),
        
            MaterialButton(
              onPressed: register,
              color: Colors.white,
              minWidth: double.infinity,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                'Register',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
        
            SizedBox(
              height: 20,
            ),
        
            GestureDetector(
              onTap: () {
                navigateToLogin();
              },
              child: Text(
                "If you already have an account?",
                style: TextStyle(
                  color: Colors.blue
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
