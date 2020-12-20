import 'package:agriglance/Screens/Test/SingleSubject.dart';
import 'package:agriglance/Services/authenticate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants/question_card.dart';

class QuestionsList extends StatefulWidget {
  final String subjectName;
  final String testname;

  QuestionsList({this.subjectName, this.testname});

  @override
  _QuestionsListState createState() => _QuestionsListState();
}

class _QuestionsListState extends State<QuestionsList> {
  List<String> _options = [];
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: (FirebaseAuth.instance.currentUser != null)
          ? FloatingActionButton(
              child: Icon(Icons.done),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Submitted test Successfully.")));
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SingleSubject()));
              })
          : FloatingActionButton(
              child: Column(
                children: [Icon(Icons.login), Text("Login")],
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(width: 2.0)),
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Authenticate()));
              }),
      appBar: AppBar(
        title: Text("Agriglance"),
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
                  Container(
                    child: Text(
                      "${widget.subjectName} - ${widget.testname}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "Roboto",
                          fontSize: screenHeight * 0.035),
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("testQuestions")
                          .doc(widget.testname)
                          .collection("questions")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Text("Loading");
                        }

                    final questionNames = snapshot.data.docs;
                    List<QuestionCard> questionsWidgets = [];
                    for (var question in questionNames) {
                      final questionTest = question.get('Question').toString();
                      final option1 = question.get('option1').toString();
                      final option2 = question.get('option2').toString();
                      final option3 = question.get('option3').toString();
                      final option4 = question.get('option4').toString();
                      final correct = option1;
                      _options.add(option1);
                      _options.add(option2);
                      _options.add(option3);
                      _options.add(option4);
                      _options.shuffle();

                      final questionWidget = QuestionCard(
                        subjectName: widget.subjectName,
                        testName: widget.testname,
                        question: questionTest,
                        option1: _options[0],
                        option2: _options[1],
                        option3: _options[2],
                        option4: _options[3],
                        correct: correct,
                      );

                          questionsWidgets.add(questionWidget);
                        }

                        return (ListView(children: questionsWidgets));
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
