// ignore_for_file: prefer_const_constructors

import "package:abnews/pages/AuthPage.dart";
import "package:abnews/pages/FavoritePage.dart";
import "package:abnews/pages/HomePage.dart";
import "package:abnews/utility/AlertBox.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import "package:abnews/providers/StoryProvider.dart";

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {

  var selectedNotiBarIndex = 0;

  List<Map<String, dynamic>>? _storyDetails;

  late StoryProvider storyProvider;

  bool isLoading = true;

  late Widget page;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.watch<StoryProvider>().getStoryDetails().then((details) {
      setState(() {
        _storyDetails = details;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    switch (selectedNotiBarIndex) {
      case 0:
        page = HomePage(isLoading: isLoading, storyDetails: _storyDetails);
        break;
      case 1:
        page = FavoritePage();
        break;
      case 2:
        page = AuthPage();
        break;
      default:
        page = HomePage(isLoading: isLoading, storyDetails: _storyDetails);
        break;
    }

    void _navigateToAuth() {
      setState(() {
        selectedNotiBarIndex = 2;
      });
    }

    return Scaffold(
      appBar: AppBar(
         title: StreamBuilder<User?>(
           stream: FirebaseAuth.instance.authStateChanges(),
           builder: (context, snapshot) {
             return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ABNews',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  )
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[500],
                    borderRadius: BorderRadius.circular(12)
                  ),
                  padding: EdgeInsets.all(12),
                  child: GestureDetector(
                    onTap: () => snapshot.hasData ? logout() : _navigateToAuth(),
                    child: Icon(
                      snapshot.hasData ? Icons.logout : Icons.login,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
                     );
           }
         ),
        toolbarHeight: 70,
        elevation: 10,
      ),
      backgroundColor: Colors.black,
      bottomNavigationBar: SizedBox(
        child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
          ],
          selectedItemColor: Colors.blue,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          currentIndex: selectedNotiBarIndex,
          onTap: (index) {
            setState(() {
              selectedNotiBarIndex = index;
            });
          },
        ),
      ),
      body: Center(
        child: Builder(
          builder: (context) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ChangeNotifierProvider(
                        create: (context) => StoryProvider(),
                        child: page,
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        ),
      ),
    );
  }

  void logout() {
    CustomAlertBox(context, 'Logout', 'Are you sure you want to logout?', FirebaseAuth.instance.signOut);
  }
}
