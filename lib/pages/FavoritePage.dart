// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:abnews/utility/StoryList.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {

    Widget page;

    if (FirebaseAuth.instance.currentUser != null) {
      page = DataPage();
    } else {
      page = NoDataPage();
    }

    return page;
  }
}

class DataPage extends StatelessWidget {
  const DataPage({super.key});

  @override
  Widget build(BuildContext context) {
        return StreamBuilder(
      stream: FirebaseFirestore.instance
                    .collection("Favorites")
                    .where("user", isEqualTo: FirebaseAuth.instance.currentUser!.email)
                    .orderBy("TimeStamp", descending: true)
                    .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          print("Error: ${snapshot.error}");
          return Text("Error");
        } else if (snapshot.data!.docs.isEmpty) {
          return NoDataPage();
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.75,
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final post = snapshot.data!.docs[index];
                  return StoryList(title: post['title'], author: post['author'], FavPage: true,);
                },
              ),
            ),
          );
        }
      }
    );
  }
  }


class NoDataPage extends StatelessWidget {
  const NoDataPage({super.key});

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
                    'There is no favorite news',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
