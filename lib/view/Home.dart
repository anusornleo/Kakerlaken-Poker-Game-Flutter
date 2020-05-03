import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testapp/view/InputPin.dart';

import 'Login.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final prefs = SharedPreferences.getInstance();
  String displayName = '';
  String photoURL =
      'https://imsc.usc.edu/wp-content/uploads/2017/10/no_photo.png';

  Future initState() {
    super.initState();
    getUser();
  }

  Future<String> getUser() async {
    FirebaseUser user = await _auth.currentUser();
    print(user.photoUrl);
    // final prefs = await SharedPreferences.getInstance();
    // final name = await prefs.get('displayName');
    // final photo = await prefs.get('photoUrl');
    setState(() {
      displayName = user.displayName;
      photoURL = user.photoUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(backgroundColor: GFColors.FOCUS, title: Text("Home")),
      body: Column(
        children: <Widget>[
          GFAvatar(
              size: 72,
              backgroundImage: NetworkImage(photoURL),
              backgroundColor: GFColors.LIGHT),
          Text(displayName),
          Column(
            children: <Widget>[
              Center(
                child: GFButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => InputPin()));
                  },
                  text: "Input Pin",
                ),
              ),
              Center(
                child: GFButton(
                  onPressed: () {},
                  text: "Creat Room",
                ),
              ),
              Center(
                child: GFButton(
                  onPressed: () {
                    signOut(context);
                  },
                  color: GFColors.DANGER,
                  text: "Log out",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void signOut(BuildContext context) {
    _auth.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Login()),
        ModalRoute.withName('/'));
  }
}
