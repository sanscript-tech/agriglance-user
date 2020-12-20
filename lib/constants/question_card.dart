import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class QuestionCard extends StatefulWidget {
  QuestionCard(
      {this.subjectName,
      this.testName,
      this.question,
      this.option1,
      this.option2,
      this.option3,
      this.option4,
      this.correct});

  final String question;
  final String option1;
  final String option2;
  final String option3;
  final String option4;
  final String testName;
  final String subjectName;
  final String correct;

  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  String _optionSelected = "";
  bool _isAttempted = false;
  int _totalCorrectAnswered = 0;
  int _totalIncorrectAnswered = 0;

  var _uid = FirebaseAuth.instance.currentUser != null
      ? FirebaseAuth.instance.currentUser.uid
      : "";

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20.0,
      child: Column(
        children: <Widget>[
          Text(widget.question),
          SizedBox(height: 5.0),
          GestureDetector(
            onTap: () async {
              if (!_isAttempted) {
                setState(() {
                  _optionSelected = widget.option2;
                });

                if (widget.option2 == widget.correct) {
                  _totalCorrectAnswered++;
                } else {
                  _totalIncorrectAnswered++;
                }
              }
              _isAttempted = true;
              if (FirebaseAuth.instance.currentUser != null) {
                await FirebaseFirestore.instance
                    .collection("attemptedTest")
                    .doc(_uid)
                    .collection("tests")
                    .doc(widget.testName)
                    .set({
                  "uid": _uid,
                  "totalCorrect": _totalCorrectAnswered,
                  "totalIncorrect": _totalIncorrectAnswered,
                  "testName": widget.testName
                });
              }
            },
            child: OptionTile(
              correctAnswer: widget.correct,
              description: widget.option2,
              option: "A",
              optionSelected: _optionSelected,
            ),
          ),
          SizedBox(
            height: 3.0,
          ),
          GestureDetector(
            onTap: () async {
              if (!_isAttempted) {
                setState(() {
                  _optionSelected = widget.option3;
                });

                if (widget.option3 == widget.correct) {
                  _totalCorrectAnswered++;
                } else {
                  _totalIncorrectAnswered++;
                }
              }
              _isAttempted = true;
              if (FirebaseAuth.instance.currentUser != null) {
                await FirebaseFirestore.instance
                    .collection("attemptedTest")
                    .doc(_uid)
                    .collection("tests")
                    .doc(widget.testName)
                    .set({
                  "uid": _uid,
                  "totalCorrect": _totalCorrectAnswered,
                  "totalIncorrect": _totalIncorrectAnswered,
                  "testName": widget.testName
                });
              }
            },
            child: OptionTile(
              correctAnswer: widget.correct,
              description: widget.option3,
              option: "B",
              optionSelected: _optionSelected,
            ),
          ),
          SizedBox(
            height: 3.0,
          ),
          GestureDetector(
            onTap: () async {
              if (!_isAttempted) {
                setState(() {
                  _optionSelected = widget.option1;
                });

                if (widget.option1 == widget.correct) {
                  _totalCorrectAnswered++;
                } else {
                  _totalIncorrectAnswered++;
                }
              }
              _isAttempted = true;
              if (FirebaseAuth.instance.currentUser != null) {
                await FirebaseFirestore.instance
                    .collection("attemptedTest")
                    .doc(_uid)
                    .collection("tests")
                    .doc(widget.testName)
                    .set({
                  "uid": _uid,
                  "totalCorrect": _totalCorrectAnswered,
                  "totalIncorrect": _totalIncorrectAnswered,
                  "testName": widget.testName
                });
              }
            },
            child: OptionTile(
              correctAnswer: widget.correct,
              description: widget.option1,
              option: "C",
              optionSelected: _optionSelected,
            ),
          ),
          SizedBox(
            height: 3.0,
          ),
          GestureDetector(
            onTap: () async {
              if (!_isAttempted) {
                setState(() {
                  _optionSelected = widget.option4;
                });

                if (widget.option4 == widget.correct) {
                  _totalCorrectAnswered++;
                } else {
                  _totalIncorrectAnswered++;
                }
              }
              _isAttempted = true;
              if (FirebaseAuth.instance.currentUser != null) {
                await FirebaseFirestore.instance
                    .collection("attemptedTest")
                    .doc(_uid)
                    .collection("quiz")
                    .doc(widget.testName)
                    .set({
                  "uid": _uid,
                  "totalCorrect": _totalCorrectAnswered,
                  "totalIncorrect": _totalIncorrectAnswered,
                  "testName": widget.testName
                });
              }
            },
            child: OptionTile(
              correctAnswer: widget.correct,
              description: widget.option4,
              option: "D",
              optionSelected: _optionSelected,
            ),
          ),
          SizedBox(
            height: 3.0,
          ),
        ],
      ),
    );
  }
}

class OptionTile extends StatefulWidget {
  final String option, description, correctAnswer, optionSelected;

  OptionTile(
      {this.description, this.correctAnswer, this.option, this.optionSelected});

  @override
  _OptionTileState createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Container(
            height: 28,
            width: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(
                    color: widget.optionSelected == widget.description
                        ? widget.description == widget.correctAnswer
                            ? Colors.green.withOpacity(0.7)
                            : Colors.red.withOpacity(0.7)
                        : Colors.grey,
                    width: 1.5),
                color: widget.optionSelected == widget.description
                    ? widget.description == widget.correctAnswer
                        ? Colors.green.withOpacity(0.7)
                        : Colors.red.withOpacity(0.7)
                    : Colors.white,
                borderRadius: BorderRadius.circular(24)),
            child: Text(
              widget.option,
              style: TextStyle(
                color: widget.optionSelected == widget.description
                    ? Colors.white
                    : Colors.grey,
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            widget.description,
            style: TextStyle(fontSize: 17, color: Colors.black54),
          )
        ],
      ),
    );
  }
}
