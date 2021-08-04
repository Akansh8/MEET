import 'package:flutter/material.dart';

import '../variables.dart';
import 'screens.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int page = 0;
  List pageOptions = [VideoConferenceScreen(), ProfileScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blueAccent.shade400,
        selectedLabelStyle: myStyle(
          17,
          Colors.black,
        ),
        unselectedItemColor: Colors.blueGrey,
        unselectedLabelStyle: myStyle(17, Colors.black),
        currentIndex: page,
        onTap: (index) {
          setState(() {
            page = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.video_call,
                size: 32,
              ),
              label: "Video Call"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 32,
              ),
              label: "Profile"),
        ],
      ),
      body: pageOptions[page],
    );
  }
}
