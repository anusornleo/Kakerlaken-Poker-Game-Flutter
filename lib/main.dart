import 'package:flutter/material.dart';
import 'package:testapp/view/CheckLogin.dart';
import 'package:testapp/view/Home.dart';
import 'package:testapp/view/Login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // initialRoute: '/',
      // routes: {
      //   '/':(context) => Home(),
      //   '/login':(context) => Login()
      // },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CheckLogin(),
    );
  }
}