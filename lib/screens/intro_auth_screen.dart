import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:my_meet/authentication/authentication.dart';

import '../variables.dart';

class IntroAuthScreen extends StatefulWidget {
  const IntroAuthScreen({Key key}) : super(key: key);

  @override
  _IntroAuthScreenState createState() => _IntroAuthScreenState();
}

class _IntroAuthScreenState extends State<IntroAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Welcome",
          body: "Welcome to MEET,thanks for choosing MEET",
          image: Center(
            child: Image.asset(
              'images/welcome.png',
              height: 175,
            ),
          ),
          decoration: PageDecoration(
            bodyTextStyle: myStyle(20, Colors.black),
            titleTextStyle: myStyle(20, Colors.black),
          ),
        ),
        PageViewModel(
          title: "Join or start meetings",
          body: "Easy to use interface,join or start meetings quickly",
          image: Center(
            child: Image.asset(
              'images/conference.png',
              height: 175,
            ),
          ),
          decoration: PageDecoration(
            bodyTextStyle: myStyle(20, Colors.black),
            titleTextStyle: myStyle(20, Colors.black),
          ),
        ),
        PageViewModel(
          title: "Security",
          body: "Your security is important for us",
          image: Center(
            child: Image.asset(
              'images/secure.jpg',
              height: 175,
            ),
          ),
          decoration: PageDecoration(
            bodyTextStyle: myStyle(20, Colors.black),
            titleTextStyle: myStyle(20, Colors.black),
          ),
        ),
      ],
      onDone: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => NavigateAuthScreen()));
      },
      onSkip: () {},
      showNextButton: true,
      showSkipButton: true,
      skip: const Icon(
        Icons.skip_next,
        size: 45,
      ),
      next: const Icon(
        Icons.navigate_next,
        size: 45,
      ),
      done: Text(
        'Done',
        style: myStyle(20, Colors.black),
      ),
    );
  }
}
