import 'package:flutter/material.dart';
import 'package:flutter_verification_code_input/flutter_verification_code_input.dart';
import 'package:getflutter/getflutter.dart';

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
            autofocus: false,
          ),
        ));
  }

  checkPin(pin){
    print(pin);
  }
}
