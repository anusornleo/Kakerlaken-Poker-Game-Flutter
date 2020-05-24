import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/colors/gf_color.dart';
import 'package:getflutter/components/appbar/gf_appbar.dart';
import 'package:getflutter/components/avatar/gf_avatar.dart';
import 'package:getflutter/components/list_tile/gf_list_tile.dart';
import 'package:getflutter/getflutter.dart';

class InRoom extends StatefulWidget {
  final String pin;
  InRoom(this.pin);

  @override
  _InRoomState createState() => _InRoomState(pin);
}

class _InRoomState extends State<InRoom> {
  final String pin;
  _InRoomState(this.pin);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GFAppBar(
            backgroundColor: GFColors.FOCUS,
            title: Text("Create Room"),
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                showAlertDialog(context);
              },
            )),
        body: Column(
          children: <Widget>[
            Text(pin),
            StreamBuilder(
              stream: Firestore.instance
                  .collection('rooms')
                  .document(pin)
                  .collection("member")
                  .snapshots(),
              builder: buildUserList,
            ),
          ],
        ));
  }

  Widget buildUserList(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasData) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: snapshot.data.documents.length,
        itemBuilder: (context, index) {
          DocumentSnapshot user = snapshot.data.documents[index];
          print(user.data);
          return GFListTile(
            avatar: GFAvatar(
                size: GFSize.MEDIUM,
                backgroundImage: NetworkImage(user.data['photoUrl']),
                backgroundColor: GFColors.LIGHT),
            titleText: user.data['displayName'],
            subtitleText: user.data['email'],
            subTitle: Text("dddd"),
            title: Text("data"),
          );
        },
      );
    } else if (snapshot.connectionState == ConnectionState.done &&
        !snapshot.hasData) {
      // Handle no data
      return Center(
        child: Text("No users found."),
      );
    } else {
      // Still loading
      return Center(child: CircularProgressIndicator());
    }
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
