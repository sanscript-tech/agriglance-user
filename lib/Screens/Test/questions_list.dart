import 'package:agriglance/Screens/Test/SingleSubject.dart';
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
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
          floatingActionButton: FloatingActionButton(
          child: Icon(Icons.done),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Submitted test Successfully.")));
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SingleSubject()));
          }),
      appBar: AppBar(
        title: Text("Agriglance"),
        centerTitle: true,
      ),
      body: SafeArea(
          top: true,
          bottom: true,
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
                      final questionWidget = QuestionCard(
                        subjectName: widget.subjectName,
                        testName: widget.testname,
                        question: questionTest,
                        option1: option1,
                        option2: option2,
                        option3: option3,
                        option4: option4,
                      );

                      questionsWidgets.add(questionWidget);
                    }

                    return (ListView(children: questionsWidgets));
                  },
                ),
              ),
            ],
          )),
    );
  }
}
