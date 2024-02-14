import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StoryProvider extends ChangeNotifier {
  List<Map<String, dynamic>>? _storiesDetail;

  Future<List<Map<String, dynamic>>> getStoryDetails() async {
    if (_storiesDetail != null) {
      return _storiesDetail!;
    }

    var storyIds = await _getStories();
    List<Map<String, dynamic>> details = [];

    for (var id in storyIds) {
      var response = await http.get(
        Uri.https('hacker-news.firebaseio.com', '/v0/item/$id.json', {'print': 'pretty'}),
      );

      if (response.statusCode == 200) {
        details.add(jsonDecode(response.body));
      } else {
        print('Error fetching story details for ID: $id');
      }
    }

    _storiesDetail = details;
    notifyListeners();
    return details;
  }

  Future<List<int>> _getStories() async {
    var response = await http.get(Uri.https('hacker-news.firebaseio.com', '/v0/newstories.json', {'print': 'pretty'}));

    if (response.statusCode == 200) {
      return List<int>.from(jsonDecode(response.body)).take(10).toList();
    }

    return [];
  }
}
