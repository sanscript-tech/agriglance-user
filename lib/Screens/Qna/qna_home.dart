import 'package:agriglance/Screens/Materials/materials_home.dart';
import 'package:agriglance/Screens/Qna/add_question.dart';
import 'package:agriglance/constants/qna_card.dart';
import 'package:agriglance/services/admob_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class QnaHome extends StatefulWidget {
  @override
  _QnaHomeState createState() => _QnaHomeState();
}

class _QnaHomeState extends State<QnaHome> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final ams = AdMobService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                .collection("qna")
                .orderBy('askedOn')
                .snapshots(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? Text("Loading")
                  : ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot q = snapshot.data.documents[index];
                        return QnaCard(
                          category: q['categoryType'],
                          question: q['question'],
                          description: q['questionDesc'],
                          postedBy: q['postedByName'],
                          index: index,
                          qid: q.id,
                        );
                      },
                    );
            },
          ),
        ),
      ),
      floatingActionButton: (FirebaseAuth.instance.currentUser != null)
          ? FloatingActionButton(
              child: Icon(Icons.add),
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
                noOfClicks++;
                print("No of clicks $noOfClicks");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddQuestionScreen(
                            uid: auth.currentUser.uid,
                            uName: auth.currentUser.displayName)));
              },
            )
          : null,
    );
  }
}
