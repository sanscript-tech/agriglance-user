import 'package:flutter/material.dart';
import '../Screens/Quiz/quiz_question_list.dart';

class QuizCard extends StatelessWidget {
  QuizCard({this.quizName, this.uid, this.currentUser});
  final String quizName;
  final String uid;
  final String currentUser;
  bool isAvailable = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (uid == currentUser) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    "You can't attempt the quiz as the quiz is created by you.")));
          } else {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => QuizQuestions(quizName:quizName,)));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                border: Border(
                    right: BorderSide(color: Colors.black, width: 2.0),
                    left: BorderSide(color: Colors.black, width: 2.0),
                    top: BorderSide(color: Colors.black, width: 2.0),
                    bottom: BorderSide(color: Colors.black, width: 2.0))),
            child: (ListTile(
              title: isAvailable
                  ? Text("$quizName")
                  : Text("$quizName- Not Available",
                      style: TextStyle(fontSize: 30.0)),
            )),
          ),
        ));
  }
}
