// ignore_for_file: prefer_const_constructors

import 'package:abnews/firebase_options.dart';
import 'package:abnews/providers/StoryProvider.dart';
import 'package:flutter/material.dart';
import 'package:abnews/pages/MyPage.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StoryProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyPage(),
      ),
    );
  }
}
