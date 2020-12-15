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
  final _uid = FirebaseAuth.instance.currentUser.uid;
  final _uname = FirebaseAuth.instance.currentUser.displayName;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          tooltip: "Add quiz",
          child: Column(
            children: <Widget>[
              Icon(
                Icons.add,
                size: 40.0,
              ),
              Text(
                "Add Quiz",
                style: TextStyle(fontSize: 10.0),
              ),
            ],
          ),
          backgroundColor: Colors.amber,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Quiz()));
          }),
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
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Text("Loading");
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
          )),
    );
  }
}
