import 'package:flutter/material.dart';
import 'package:my_meet/variables.dart';
import 'package:my_meet/video_conference/video_conference.dart';

class VideoConferenceScreen extends StatefulWidget {
  const VideoConferenceScreen({Key key}) : super(key: key);

  @override
  _VideoConferenceScreenState createState() => _VideoConferenceScreenState();
}

class _VideoConferenceScreenState extends State<VideoConferenceScreen>
    with TickerProviderStateMixin {
  TabController tabController;
  buildTab(String s) {
    return Container(
      width: 150,
      height: 50,
      child: Card(
        child: Center(
          child: Text(
            s,
            style: myStyle(15, Colors.black, FontWeight.w700),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MEET",
          style: myStyle(20, Colors.white, FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        bottom: TabBar(
          controller: tabController,
          tabs: [
            buildTab("Join Meeting"),
            buildTab("Create Meeting"),
          ],
        ),
      ),
      body: TabBarView(controller: tabController, children: [
        JoinMeeting(),
        CreateMeeting(),
      ]),
    );
  }
}
