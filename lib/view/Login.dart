import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GFAppBar(
          backgroundColor: GFColors.FOCUS,
          title: Text("Login"),
        ),
        body: Container(child: Center(child: buildButtonGoogle(context))));
  }

  Widget buildButtonGoogle(BuildContext context) {
    return InkWell(
        child: Container(
            constraints: BoxConstraints.expand(height: 50),
            child: Text("Login with Google ",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.blue[600])),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16), color: Colors.white),
            margin: EdgeInsets.only(top: 12),
            padding: EdgeInsets.all(12)),
        onTap: () => loginWithGoogle(context));
  }

  Future loginWithGoogle(BuildContext context) async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    GoogleSignInAccount user = await _googleSignIn.signIn();
    GoogleSignInAuthentication userAuth = await user.authentication;

    try{
      await _auth
        .signInWithCredential(GoogleAuthProvider.getCredential(
            idToken: userAuth.idToken, accessToken: userAuth.accessToken));

    // print(_googleSignIn.currentUser);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('email', '${_googleSignIn.currentUser.email}');
    prefs.setString('displayName', _googleSignIn.currentUser.displayName);
    prefs.setString('photoUrl', _googleSignIn.currentUser.photoUrl);

    Firestore.instance
        .collection("users")
        .document(_googleSignIn.currentUser.email)
        .setData({
      "email": _googleSignIn.currentUser.email,
      "displayName": _googleSignIn.currentUser.displayName,
      "photoUrl": _googleSignIn.currentUser.photoUrl
    });

    checkAuth(context); // after success route to home.
    }catch(e){
      print(e);
    }

    
  }

  Future checkAuth(BuildContext context) async {
    FirebaseUser user = await _auth.currentUser();
    print(user.email);
    if (user != null) {
      print("Already singed-in with");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    }
  }
}
