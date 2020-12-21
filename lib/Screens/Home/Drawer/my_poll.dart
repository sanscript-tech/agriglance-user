import 'package:agriglance/constants/poll_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyPoll extends StatefulWidget {
  @override
  _MyPollState createState() => _MyPollState();
}

class _MyPollState extends State<MyPoll> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Polls"),
      ),
      body: Center(
        child: Container(
          width: 700.0,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 25.0, // soften the shadow
              spreadRadius: 5.0, //extend the shadow
              offset: Offset(
                15.0,
                15.0,
              ),
            )
          ], color: Colors.yellow[50], border: Border.all(color: Colors.white)),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("polls")
                .where("postedBy", isEqualTo: auth.currentUser.uid.toString())
                .orderBy('createdOn')
                .snapshots(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot p = snapshot.data.documents[index];
                        return PollCard(
                          voters: p['voters'],
                          question: p['question'],
                          option1: p['option1'],
                          option2: p['option2'],
                          option3: p['option3'],
                          option4: p['option4'],
                          totalVotesOnOption1: p['totalVotesOnOption1'],
                          totalVotesOnOption2: p['totalVotesOnOption2'],
                          totalVotesOnOption3: p['totalVotesOnOption3'],
                          totalVotesOnOption4: p['totalVotesOnOption4'],
                          postedByName: p['postedByName'],
                          approved: p['isApprovedByAdmin'],
                          index: index,
                          pollID: p.id,
                        );
                      },
                    );
            },
          ),
        ),
      ),
    );
  }
}
