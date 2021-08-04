import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:my_meet/authentication/authentication.dart';
import 'package:my_meet/screens/intro_auth_screen.dart';
import 'package:my_meet/variables.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = '';
  bool dataPresent = false;
  TextEditingController usernameController = new TextEditingController();
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
      dataPresent = true;
    });
  }

  openEditProfileDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: 200,
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 30),
                    child: TextField(
                      controller: usernameController,
                      style: myStyle(18, Colors.black),
                      decoration: InputDecoration(
                        labelText: "Update Username",
                        labelStyle: myStyle(16, Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () => editProfile(),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 40,
                      decoration: BoxDecoration(
                          gradient:
                              LinearGradient(colors: GradientColors.cherry)),
                      child: Center(
                        child: Text(
                          "Update now",
                          style: myStyle(17, Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  editProfile() async {
    setState(() {
      if (usernameController.text.isNotEmpty) {
        userCollection.doc(FirebaseAuth.instance.currentUser.uid).update({
          'username': usernameController.text,
        });
        username = usernameController.text;
      }
      Navigator.pop(context);
    });
  }

  logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => IntroAuthScreen()));
    } catch (e) {
      print('Error : $e');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[250],
      body: dataPresent == false
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                ClipPath(
                  clipper: OvalBottomBorderClipper(),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 2.5,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: GradientColors.facebookMessenger)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 2 - 64,
                      top: MediaQuery.of(context).size.height / 3.1),
                  child: CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage(
                        'https://www.kindpng.com/picc/m/24-248253_user-profile-default-image-png-clipart-png-download.png'),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 300,
                      ),
                      Text(
                        username,
                        style: myStyle(40, Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () => openEditProfileDialog(),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 40,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: GradientColors.cherry)),
                          child: Center(
                            child: Text(
                              "Edit Profile",
                              style: myStyle(17, Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () => logout(),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 40,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: GradientColors.cherry)),
                          child: Center(
                            child: Text(
                              "Logout",
                              style: myStyle(17, Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
