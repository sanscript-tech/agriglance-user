import 'package:agriglance/Services/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key key, @required this.user}) : super(key: key);
  final User user;

  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Agriglance")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              Text('Welcome  ${widget.user.email}'),
              RaisedButton(
                onPressed: () {
                  context.read<AuthenticationService>().signOut();
                },
                child: Text('SignOut'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
