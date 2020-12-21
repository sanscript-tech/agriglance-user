import 'package:agriglance/Screens/Materials/materials_home.dart';
import 'package:agriglance/Screens/Polls/add_polls.dart';
import 'package:agriglance/constants/poll_card.dart';
import 'package:agriglance/services/admob_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PollHome extends StatefulWidget {
  @override
  _PollHomeState createState() => _PollHomeState();
}

class _PollHomeState extends State<PollHome> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final ams = AdMobService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Polls"),
        centerTitle: true,
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
          ], color: Colors.amber[100], border: Border.all(color: Colors.white)),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("polls")
                .orderBy('isApprovedByAdmin', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? Text("Loading")
                  : ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot p = snapshot.data.documents[index];
                        if (p['isApprovedByAdmin']) {
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
                            postedBy: p['postedBy'],
                            approved: p['isApprovedByAdmin'],
                            index: index,
                            pollID: p.id,
                          );
                        }
                        return null;
                      },
                    );
            },
          ),
        ),
      ),
      floatingActionButton: (FirebaseAuth.instance.currentUser != null)
          ? FloatingActionButton(
              onPressed: () {
                if (!kIsWeb && noOfClicks % 5 == 0) {
                  InterstitialAd newAd = ams.getInterstitialAd();
                  newAd.load();
                  newAd.show(
                    anchorType: AnchorType.bottom,
                    anchorOffset: 0.0,
                    horizontalCenterOffset: 0.0,
                  );
                  noOfClicks++;
                }
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddPoll()));
              },
              child: Icon(Icons.add),
            )
          : null,
    );
  }
}
