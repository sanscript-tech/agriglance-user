import 'package:agriglance/Screens/Quiz/quiz_home.dart';
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
  int numOfQuestions = 0;

  Future<void> getNumberQuestions() async {
    numOfQuestions = await FirebaseFirestore.instance
        .collection("QuizTestName")
        .doc(widget.quizName)
        .collection("questions")
        .snapshots()
        .length;
  }

  @override
  void initState() {
    // TODO: implement initState
    getNumberQuestions();
    print(numOfQuestions);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.done),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Submitted Quiz Successfully.")));
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => QuizHome()));
          }),
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
                      return Center(child: CircularProgressIndicator());
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
                        quizName: widget.quizName,
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
