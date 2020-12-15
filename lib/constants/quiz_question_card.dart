import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  QuestionCard(
      {this.question, this.option1, this.option2, this.option3, this.option4,this.correct});
  final String question;
  final String option1;
  final String option2;
  final String option3;
  final String option4;
  final String correct;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20.0,
      child: Column(children: <Widget>[
        Text(question),
        Row(children: <Widget>[
          Text(option1),
          Text(option2),
        ]),
        Row(children: <Widget>[
          Text(option3),
          Text(option4),
        ]),
      ]),
    );
  }
}
