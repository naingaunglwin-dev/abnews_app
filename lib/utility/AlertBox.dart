// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<void> CustomAlertBox(
  BuildContext context,
  String title,
  String message,
  Function()? action,
) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (action != null) {
                await action();
              }
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

Future<void> toggleFavorite(
  BuildContext context,
  String? user,
  String title,
  String author
) async {
  try {
    final favoritesCollection = FirebaseFirestore.instance.collection("Favorites");
    final existingFavorites = await favoritesCollection
        .where('title', isEqualTo: title)
        .where('author', isEqualTo: author)
        .where('user', isEqualTo: user)
        .get();

    if (existingFavorites.docs.isNotEmpty) {
      for (final doc in existingFavorites.docs) {
        await doc.reference.delete();
      }
    } else {
      await favoritesCollection.add({
        'title': title,
        'author': author,
        'user': user,
        'TimeStamp': Timestamp.now(),
      });
    }
  } catch (error) {
    CustomAlertBox(
      context,
      'Error',
      'Failed to toggle favorite: $error',
      null
    );
  }
}
