import 'package:agriglance/Services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyPoints extends StatefulWidget {
  @override
  _MyPointsState createState() => _MyPointsState();
}

class _MyPointsState extends State<MyPoints> {
  FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Points"),
      ),
      body: Column(
        children: [
          FutureBuilder(
              future: _firestoreService
                  .getUser(FirebaseAuth.instance.currentUser.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return displayUserInformation(context, snapshot);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ],
      ),
    );
  }

  Widget displayUserInformation(
      BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    final userData = snapshot.data;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Center(
            child: Container(
              width: 300.0,
              height: 300.0,
              decoration: new BoxDecoration(
                color: Colors.yellow,
                shape: BoxShape.circle,
              ),
              child: Center(
                  child: Text(
                userData.points.toString(),
                style: TextStyle(fontSize: 50.0, color: Colors.blue),
              )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                "NOTE: Every month top ten users will be drawn based on user activity and will be awarded prize. Best user of the month will be awarded Rs. 1000 through paytm. Every month the points are set back to 0."),
          )
        ],
      ),
    );
  }
}
