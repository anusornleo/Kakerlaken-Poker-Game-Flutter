import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:getflutter/getflutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'InRoom.dart';

class CreateRoom extends StatefulWidget {
  @override
  _CreateRoomState createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
  int randomRange = 10000;
  String pin = '0000';

  void initState() {
    super.initState();
    createRoom(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GFAppBar(
          backgroundColor: GFColors.FOCUS,
          title: Text("Create Room"),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {},
          ),
        ),
        body: Center(child: CircularProgressIndicator())
        //       child: Column(children: <Widget>[

        //   // Center(child: Text(pin)),
        // ]),
        );
  }

  void createRoom(BuildContext context) async {
    Random pinRandom = new Random();
    String thispin = pinRandom.nextInt(10000).toString();
    final prefs = await SharedPreferences.getInstance();
    final email = await prefs.get('email');
    final name = await prefs.get('displayName');
    final photoUrl = await prefs.get('photoUrl');
    Firestore.instance
        .collection("rooms")
        .getDocuments()
        .then((QuerySnapshot querySnapshot) {
      List<String> listRoom = new List<String>();
      querySnapshot.documents.forEach((DocumentSnapshot snapshot) {
        listRoom.add(snapshot.data["pin"]);
      });

      while (listRoom.contains(thispin)) {
        var pinRandom = new Random();
        thispin = pinRandom.nextInt(randomRange).toString();
      }

      Firestore.instance
          .collection("rooms")
          .document(thispin)
          .setData({"pin": thispin})
          .then((onValue) => {
                setState(() {
                  pin = thispin;
                }),
                Firestore.instance
                    .collection("rooms")
                    .document(thispin)
                    .collection("member")
                    .document(email)
                    .setData({
                      "email": email,
                      "is_a": "head",
                      "displayName": name,
                      "photoUrl": photoUrl
                    })
                    .then((onValue) => {
                          setState(() {
                            pin = thispin;
                          }),
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InRoom(pin)))
                        })
                    .catchError((onError) => {})
              })
          .catchError((onError) => {});
    }).catchError((e) {
      print(e);
    });
  }
}
