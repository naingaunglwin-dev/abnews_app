// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, use_build_context_synchronously

import 'package:abnews/pages/auth/RegisterPage.dart';
import 'package:abnews/pages/user/Profile.dart';
import 'package:abnews/utility/AlertBox.dart';
import 'package:abnews/utility/Validate.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late Widget page;

  @override
  void initState() {
    super.initState();
    page = Form(navigateToProfile: _navigateToProfile, navigateToRegister: _navigateToRegister);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(), 
      builder: (content, snapshot) {
        // User is logged in
        if (snapshot.hasData) {
          return Profile(email:FirebaseAuth.instance.currentUser!.email);
        }

        // User is not logged in
        return page;
      }
      );
  }

  void _navigateToRegister()
  {
    setState(() {
      page = RegisterPage();
    });
  }

  void _navigateToProfile()
  {
    setState(() {
      page = Profile(email:FirebaseAuth.instance.currentUser!.email);
    });
  }
}

class Form extends StatelessWidget {
  final navigateToProfile;
  final navigateToRegister;

  const Form({
    Key? key,
    required this.navigateToProfile,
    required this.navigateToRegister,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    void login() async {
      String username = _usernameController.text;
      String password = _passwordController.text;

      var validate = Validate(on: 'login', username: username, password: password);

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
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: username,
            password: password
          );

          navigateToProfile();
          Navigator.pop(context);
        } on FirebaseAuthException catch (e) {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }

          CustomAlertBox(context, 'Authentication Error', 'Incorrect Email or Password', null);
        }
      }
    }

    return Container(
      height: MediaQuery.of(context).size.height  * 0.75,
      child: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Login',
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
        
            SizedBox(
              height: 20,
            ),
        
            MaterialButton(
              onPressed: login,
              color: Colors.white,
              minWidth: double.infinity,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                'Login',
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
                navigateToRegister();
              },
              child: Text(
                "If you don't have an account?",
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
