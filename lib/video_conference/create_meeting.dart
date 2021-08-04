import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:my_meet/variables.dart';
import 'package:uuid/uuid.dart';

class CreateMeeting extends StatefulWidget {
  const CreateMeeting({Key key}) : super(key: key);

  @override
  _CreateMeetingState createState() => _CreateMeetingState();
}

class _CreateMeetingState extends State<CreateMeeting> {
  String code = '';
  generateCode() {
    setState(() {
      code = Uuid().v1().substring(0, 6);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              "Create a code and share with friends",
              style: myStyle(20),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Code: ",
                style: myStyle(30),
              ),
              SelectableText(
                code,
                style: myStyle(30, Colors.purple, FontWeight.w700),
                textAlign: TextAlign.center,
                onTap: () => print('Tapped'),
                toolbarOptions: ToolbarOptions(
                  copy: true,
                  selectAll: true,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          InkWell(
            onTap: () => generateCode(),
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              height: 50,
              decoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: GradientColors.facebookMessenger),
              ),
              child: Center(
                  child: Text(
                "create code",
                style: myStyle(20, Colors.white),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
