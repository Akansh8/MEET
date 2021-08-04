import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:my_meet/variables.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class JoinMeeting extends StatefulWidget {
  const JoinMeeting({Key key}) : super(key: key);

  @override
  _JoinMeetingState createState() => _JoinMeetingState();
}

class _JoinMeetingState extends State<JoinMeeting> {
  TextEditingController nameController = TextEditingController();
  TextEditingController roomController = TextEditingController();
  bool isCameraOff = true;
  bool isAudioMuted = true;
  String username = "";
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() {
    getUserData();
  }

  getUserData() async {
    DocumentSnapshot userDoc =
        await userCollection.doc(FirebaseAuth.instance.currentUser.uid).get();
    setState(() {
      username = userDoc['username'];
    });
  }

  joinMeeting() async {
    try {
      Map<FeatureFlagEnum, bool> featureFlags = {
        FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
      };
      featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      var options = JitsiMeetingOptions(room: roomController.text)
        ..userDisplayName =
            (nameController.text.isEmpty) ? (username) : (nameController.text)
        ..audioMuted = isAudioMuted
        ..videoMuted = isCameraOff
        ..featureFlags.addAll(featureFlags);

      await JitsiMeet.joinMeeting(options);
    } catch (e) {
      print("Error: $e}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 24,
              ),
              Text(
                "Room Code",
                style: myStyle(20),
              ),
              SizedBox(
                height: 20,
              ),
              PinCodeTextField(
                  controller: roomController,
                  appContext: context,
                  autoDisposeControllers: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.underline,
                  ),
                  animationDuration: Duration(microseconds: 300),
                  length: 6,
                  onChanged: (val) {}),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: nameController,
                style: myStyle(20),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Name (Leave if you want your username)",
                  labelStyle: myStyle(15),
                ),
              ),
              SizedBox(height: 16),
              CheckboxListTile(
                value: isCameraOff,
                onChanged: (value) {
                  setState(() {
                    isCameraOff = value;
                  });
                },
                title: Text(
                  "Turn Off Camera",
                  style: myStyle(18, Colors.black),
                ),
              ),
              SizedBox(height: 16),
              CheckboxListTile(
                value: isAudioMuted,
                onChanged: (value) {
                  setState(() {
                    isAudioMuted = value;
                  });
                },
                title: Text(
                  "Mute Audio",
                  style: myStyle(18, Colors.black),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "You Can Customize settings during the meeting also",
                style: myStyle(15),
                textAlign: TextAlign.center,
              ),
              Divider(
                height: 48,
                thickness: 2.0,
              ),
              InkWell(
                onTap: () => joinMeeting(),
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 64,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: GradientColors.facebookMessenger),
                  ),
                  child: Center(
                      child: Text(
                    "JOIN NOW",
                    style: myStyle(20, Colors.white),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
