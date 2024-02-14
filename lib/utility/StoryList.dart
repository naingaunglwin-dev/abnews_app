// ignore_for_file: prefer_const_constructors

import 'package:abnews/utility/AlertBox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StoryList extends StatefulWidget {

  final title;
  final author;
  final bool FavPage;

  const StoryList({
    Key? key,
    required this.title,
    required this.author,
    required this.FavPage,
  }) : super(key: key);

  @override
  State<StoryList> createState() => _StoryListState();
}

class _StoryListState extends State<StoryList> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.FavPage;
    checkFavorite();
  }

  Future<void> checkFavorite() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final snapshot = await FirebaseFirestore.instance
          .collection('Favorites')
          .where('title', isEqualTo: widget.title)
          .where('author', isEqualTo: widget.author)
          .where('user', isEqualTo: currentUser.email)
          .get();

      setState(() {
        isFavorite = snapshot.docs.isNotEmpty;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool tempFavoriteValue = isFavorite;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
              
                  SizedBox(
                    height: 5,
                  ),
              
                  Text(
                    'by ${widget.author}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.grey
                    ),
                  )
                ],
              ),
            ),

            SizedBox(
              width: 5,
            ),

            ...(FirebaseAuth.instance.currentUser != null
                ? [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          tempFavoriteValue = !tempFavoriteValue;
                        });
                        CustomAlertBox(
                          context,
                          'Confirm',
                          tempFavoriteValue ? 'Add to favorites?' : 'Remove from favorites?',
                          () {
                            setState(() {
                              isFavorite = tempFavoriteValue;
                            });
                            toggleFavorite(
                              context,
                              FirebaseAuth.instance.currentUser!.email,
                              widget.title,
                              widget.author,
                            );
                          },
                        );
                      },
                      child: Icon(
                        tempFavoriteValue
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        color: tempFavoriteValue ? Colors.red : null,
                      ),
                    ),
                  ]
                : []),
          ],
        ),
      ),
    );
  }
}
