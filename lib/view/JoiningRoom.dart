import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'InRoom.dart';

class JoiningRoom extends StatefulWidget {
  final String pin;

  JoiningRoom(this.pin);

  @override
  _JoiningRoomState createState() => _JoiningRoomState(pin);
}

class _JoiningRoomState extends State<JoiningRoom> {
  final String pin;

  _JoiningRoomState(this.pin);

  void initState() {
    super.initState();
    joinRoom(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void joinRoom(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final email = await prefs.get('email');
    final name = await prefs.get('displayName');
    final photoUrl = await prefs.get('photoUrl');

    Firestore.instance
        .collection("rooms")
        .document(pin)
        .collection("member")
        .document(email)
        .setData({
          "email": email,
          "is_a": "member",
          "displayName": name,
          "photoUrl": photoUrl
        })
        .then((onValue) => {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => InRoom(pin)))
            })
        .catchError((onError) => {});
  }
}
