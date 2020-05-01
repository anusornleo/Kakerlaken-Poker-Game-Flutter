import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';

import 'Login.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(
        backgroundColor:GFColors.DARK,
        leading: GFIconButton(
          icon: Icon(
            Icons.message,
            color: Colors.white,
          ),
          onPressed: () {},
          type: GFButtonType.transparent,
        ),
        title: Text("GF Appbar"),
        actions: <Widget>[
          GFIconButton(
            icon: Icon(
              Icons.favorite,
              color: Colors.white,
            ),
            onPressed: () {},
            type: GFButtonType.transparent,
          ),
        ],
      ),
      body: Center(
        child: GFButton(
          onPressed: () {
            signOut(context);
          },
          text: "Log out",
        ),
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
