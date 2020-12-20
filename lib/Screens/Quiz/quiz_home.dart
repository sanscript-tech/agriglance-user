import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants/quiz_card.dart';
import 'create_quiz.dart';

class QuizHome extends StatefulWidget {
  @override
  _QuizHomeState createState() => _QuizHomeState();
}

class _QuizHomeState extends State<QuizHome> {
  var _uid = FirebaseAuth.instance.currentUser!=null ? FirebaseAuth.instance.currentUser.uid : "";

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: (FirebaseAuth.instance.currentUser != null)
          ? FloatingActionButton(
              tooltip: "Add quiz",
              child: Icon(
                Icons.add,
                size: 40.0,
              ),
              backgroundColor: Colors.amber,
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Quiz()));
              })
          : null,
      appBar: AppBar(
        title: Text("Quizzes"),
        centerTitle: true,
      ),
      body: SafeArea(
          top: true,
          bottom: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.03),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("QuizTestName")
                      .orderBy("isApprovedByAdmin", descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    final testNames = snapshot.data.docs;
                    List<QuizCard> testsWidgets = [];
                    for (var test in testNames) {
                      if (test.get('isApprovedByAdmin')) {
                        final quizName = test.get('quizName').toString();
                        final uuid = test.get('uid').toString();

                        final testWidget = QuizCard(
                          quizName: quizName,
                          uid: uuid,
                          currentUser: _uid,
                        );

                        testsWidgets.add(testWidget);
                      }
                    }

                    return (ListView(children: testsWidgets));
                  },
                ),
              ),
            ],
          )),
    );
  }
}
