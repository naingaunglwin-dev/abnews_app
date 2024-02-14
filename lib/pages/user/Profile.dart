// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final String? email;

  const Profile({
    Key? key,
    this.email
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      child: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Logged In as $email',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20
              ),
            ),
          ],
        ),
      ),
    );
  }
}
