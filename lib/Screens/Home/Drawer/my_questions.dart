import 'package:agriglance/constants/qna_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyQuestions extends StatefulWidget {
  @override
  _MyQuestionsState createState() => _MyQuestionsState();
}

class _MyQuestionsState extends State<MyQuestions> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QNA"),
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
                .collection("qna")
                .where("postedBy", isEqualTo: auth.currentUser.uid.toString())
                .snapshots(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? Center(child: CircularProgressIndicator())
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
    );
  }
}
