import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants/quiz_question_card.dart';

class QuizQuestions extends StatefulWidget {
  QuizQuestions({this.quizName});
  final String quizName;
  @override
  _QuizQuestionsState createState() => _QuizQuestionsState();
}

class _QuizQuestionsState extends State<QuizQuestions> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.quizName),
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
                      .doc(widget.quizName)
                      .collection("questions")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Text("Loading");
                    }

                    final questionNames = snapshot.data.docs;
                    List<QuestionCard> questionsWidgets = [];
                    for (var question in questionNames) {
                      final questionTest = question.get('ques').toString();
                      final option1 = question.get('option1').toString();
                      final option2 = question.get('option2').toString();
                      final option3 = question.get('option3').toString();
                      final option4 = question.get('option4').toString();
                      final correct = question.get('correct').toString();
                      final questionWidget = QuestionCard(
                        question: questionTest,
                        option1: option1,
                        option2: option2,
                        option3: option3,
                        option4: option4,
                        correct: correct,
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
