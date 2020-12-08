import 'package:agriglance/Screens/Polls/add_polls.dart';
import 'package:agriglance/constants/poll_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PollHome extends StatefulWidget {
  @override
  _PollHomeState createState() => _PollHomeState();
}

class _PollHomeState extends State<PollHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Polls"),
        centerTitle: true,
      ),
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("polls").snapshots(),
          builder: (context, snapshot) {
            return !snapshot.hasData
                ? Text("Loading")
                : ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      return PollCard();
                    },
                  );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddPoll())),
        child: Icon(Icons.add),
      ),
    );
  }
}
