import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
        backgroundColor:GFColors.DARK,
        title: Text("Login"),
      ),
        body: Container(
            color: Colors.green[50],
            child: Center(
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                          colors: [Colors.yellow[100], Colors.green[100]])),
                  margin: EdgeInsets.all(32),
                  padding: EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      buildTextFieldEmail(),
                      buildTextFieldPassword(),
                      buildButtonSignIn(),
                      buildButtonGoogle(context)
                    ],
                  )),
            )));
  }

  Container buildButtonSignIn() {
    return Container(
        constraints: BoxConstraints.expand(height: 50),
        child: Text("Sign in",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.white)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: Colors.green[200]),
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(12));
  }

  Container buildTextFieldEmail() {
    return Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            decoration: InputDecoration.collapsed(hintText: "Email"),
            style: TextStyle(fontSize: 18)));
  }

  Container buildTextFieldPassword() {
    return Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            obscureText: true,
            decoration: InputDecoration.collapsed(hintText: "Password"),
            style: TextStyle(fontSize: 18)));
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

    await _auth.signInWithCredential(GoogleAuthProvider.getCredential(
        idToken: userAuth.idToken, accessToken: userAuth.accessToken));

        print(_googleSignIn.currentUser);
    // checkAuth(context); // after success route to home.
  }

  // Future checkAuth(BuildContext context) async {
  //   FirebaseUser user = await _auth.currentUser();
  //   if (user != null) {
  //     print("Already singed-in with");
  //     Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (context) => Home()));
  //   }
  // }
}
