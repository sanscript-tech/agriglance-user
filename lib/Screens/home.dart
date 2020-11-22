import 'package:agriglance/Services/authentication_service.dart';
import 'package:agriglance/Services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: FirestoreService().getReference.snapshots(),
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Agriglance")),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                context.read<AuthenticationService>().signOut();
              },
            ),
          ],
        ),
        body: Center(
            child: Text("Welcome ${FirebaseAuth.instance.currentUser.email}")),
      ),
    );
  }
}
