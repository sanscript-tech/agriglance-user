import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {

    QuestionCard(
      {this.quizName,
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
  final String correct;
  final String quizName;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20.0,
      child: Column(
        children: <Widget>[
          Text(question),
          SizedBox(height: 5.0),
          OptionTile(option: "A",description: option1,correctAnswer: correct,),
          SizedBox(height: 5.0),
          OptionTile(option:"B",description: option2,correctAnswer: correct,),
          SizedBox(height: 5.0),
          OptionTile(option: "C",description: option3,correctAnswer: correct,),
          SizedBox(height: 5.0),
          OptionTile(option: "D",description: option4,correctAnswer: correct,)

        ],
      ),
    );
  }
}

class OptionTile extends StatelessWidget {
  final String option;
  final String description;
  final String correctAnswer;
  OptionTile({this.option, this.description, this.correctAnswer});

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
                    color: description == correctAnswer
                        ? Colors.green.withOpacity(0.7)
                        : Colors.blue.withOpacity(0.7),
                    width: 1.5),
                color: description == correctAnswer
                    ? Colors.green.withOpacity(0.7)
                    : Colors.red.withOpacity(0.0),
                borderRadius: BorderRadius.circular(24)),
            child: Text(
              option,
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            description,
            style: TextStyle(fontSize: 17, color: Colors.black54),
          )
        ],
      ),
    );
  }
}
