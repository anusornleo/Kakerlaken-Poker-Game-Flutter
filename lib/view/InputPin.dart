import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code_input/flutter_verification_code_input.dart';
import 'package:getflutter/getflutter.dart';
import 'package:testapp/view/JoiningRoom.dart';

class InputPin extends StatefulWidget {
  @override
  _InputPinState createState() => _InputPinState();
}

class _InputPinState extends State<InputPin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GFAppBar(
          backgroundColor: GFColors.FOCUS,
          title: Text("Input Pin"),
        ),
        body: Center(
          child: VerificationCodeInput(
            keyboardType: TextInputType.number,
            length: 4,
            onCompleted: (String value) {
              checkPin(value);
            },
          ),
        ));
  }

  checkPin(pin) {
    Firestore.instance
        .collection("rooms")
        .document(pin)
        .get()
        .then((onValue) => {
              if (onValue.exists)
                {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => JoiningRoom(pin)))
                }
              else
                {print("room not exist"), showAlertDialog(context)}
            })
        .catchError((onError) => {});
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Exit"),
      onPressed: () {},
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Warning"),
      content: Text("Are you sure to exit this room"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
