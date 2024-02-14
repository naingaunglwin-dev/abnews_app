// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import "package:flutter/material.dart";
import 'package:abnews/utility/StoryList.dart';

class HomePage extends StatelessWidget {
  final bool isLoading;
  final List<Map<String, dynamic>>? storyDetails;

  const HomePage({
    Key? key,
    required this.isLoading,
    required this.storyDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.75,
        child: isLoading
        ? Center(
          child: CircularProgressIndicator(),
        )
         : ListView(
          children: [
            if (storyDetails != null)
              for (var story in storyDetails!)
                StoryList(
                  title: story['title'].toString(),
                  author: story['by'].toString(),
                  FavPage: false,
                ),
          ],
         )
      ),
    );
  }
}
