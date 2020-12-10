import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactAdmin extends StatefulWidget {
  @override
  _ContactAdminState createState() => _ContactAdminState();
}

class _ContactAdminState extends State<ContactAdmin> {
  final TextStyle linkStyle = TextStyle(color: Colors.blue, fontSize: 20.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Admin"),
      ),
      body: Center(
        child: RaisedButton(
          color: Colors.yellow,
            onPressed: (){
              final url = Mailto(
                to: ['sanscriptfirebase@gmail.com'],
              ).toString();
              if (canLaunch(url) != null) {
                launch(url);
              } else {
                Fluttertoast.showToast(msg: "Couldn't complete your request...",
                    gravity: ToastGravity.BOTTOM);
              }
            },
            child: Text("Click to email:\n sanscriptfirebase@gmail.com", style: linkStyle)),
      ),
    );
  }
}
