import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

import 'Home.dart';
import 'Login.dart';

class CheckLogin extends StatefulWidget {
  @override
  _CheckLoginState createState() => _CheckLoginState();
}

class _CheckLoginState extends State<CheckLogin> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future initState() {
    super.initState();
    checkAuth(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: LoadingDoubleFlipping.square(
        duration: Duration(milliseconds: 900),
      ),
    ));
  }

  Future checkAuth(BuildContext context) async {
    FirebaseUser user = await _auth.currentUser();

    if (user != null) {
      print("Already singed-in with");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    } else {
      print("Please Login");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    }
  }
}
