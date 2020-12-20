import 'package:agriglance/constants/quiz_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyQuiz extends StatefulWidget {
  @override
  _MyQuizState createState() => _MyQuizState();
}

class _MyQuizState extends State<MyQuiz> {
  final _uid = FirebaseAuth.instance.currentUser.uid;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Quizzes"),
        centerTitle: true,
      ),
      body: SafeArea(
          top: true,
          bottom: true,
          child: Center(
            child: Container(
              width: 700.0,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 25.0, // soften the shadow
                      spreadRadius: 5.0, //extend the shadow
                      offset: Offset(
                        15.0,
                        15.0,
                      ),
                    )
                  ],
                  color: Colors.amber[100],
                  border: Border.all(color: Colors.white)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.03),
                  Expanded(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("QuizTestName")
                          .where("uid",
                              isEqualTo: FirebaseAuth.instance.currentUser.uid
                                  .toString())
                          .orderBy("isApprovedByAdmin", descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }
                        final testNames = snapshot.data.docs;
                        List<QuizCard> testsWidgets = [];
                        for (var test in testNames) {
                          final quizName = test.get('quizName').toString();
                          final uuid = test.get('uid').toString();

                          final testWidget = QuizCard(
                            quizName: quizName,
                            uid: uuid,
                            currentUser: _uid,
                          );

                          testsWidgets.add(testWidget);
                        }

                        return (ListView(children: testsWidgets));
                      },
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
