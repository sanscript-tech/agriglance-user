import 'package:agriglance/Screens/Home/home.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants/quiz_score_card.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fluttertoast/fluttertoast.dart';
class QuizScore extends StatefulWidget {
  final String quizName;
  final int numOfQuestions;
  final String correctAnswers;
  final String incorrectAnswers;
  QuizScore(
      {this.quizName,
      this.numOfQuestions,
      this.correctAnswers,
      this.incorrectAnswers});
  @override
  _QuizScoreState createState() => _QuizScoreState();
}

class _QuizScoreState extends State<QuizScore> {
  List<String> _options = [];
  @override
  Widget build(BuildContext context) {
    int _unattempted = widget.numOfQuestions -
        (int.parse(widget.correctAnswers) + int.parse(widget.incorrectAnswers));
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    Map<String, double> dataMap = {
      "Total Wrong": double.parse(widget.incorrectAnswers),
      "Total Correct": double.parse(widget.correctAnswers),
      "Unattempted": double.parse(_unattempted.toString()),
    };
    return WillPopScope(
      onWillPop: () async {
          Fluttertoast.showToast(
          msg: 'Please review the answers,then return',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
        return false;
      },
      child: Scaffold(
        floatingActionButton: (FirebaseAuth.instance.currentUser != null)
            ? FloatingActionButton(
                tooltip: "Finish Review",
                child: Column(
                  children: [
                    Icon(
                      Icons.done,
                      size: 40.0,
                    ),
                    Text(
                      "Finish Review",
                      style: TextStyle(fontSize: 5.0),
                    )
                  ],
                ),
                backgroundColor: Colors.amber,
                onPressed: () {
                   Fluttertoast.showToast(
          msg: 'Check your profile to review this test again',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );


                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Home()));
                })
            : null,
        appBar: AppBar(
          title: Text("Test Score"),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: screenHeight * 0.3,
                  child: Row(
                    children: [
                      Container(
                        width: screenWidth * 0.5,
                        child: Column(
                          children: <Widget>[
                            Text("Total Questions"),
                            Text("${widget.numOfQuestions}"),
                            Text("Total Correct"),
                            Text("${widget.correctAnswers}"),
                            Text("Total Incorrect"),
                            Text("${widget.incorrectAnswers}")
                          ],
                        ),
                      ),
                      Container(
                        width: screenWidth * 0.5,
                        child: PieChart(
                          dataMap: dataMap,
                          animationDuration: Duration(milliseconds: 800),
                          chartLegendSpacing: 32,
                          chartRadius: MediaQuery.of(context).size.width,
                          initialAngleInDegree: 0,
                          chartType: ChartType.ring,
                          ringStrokeWidth: 32,
                          legendOptions: LegendOptions(
                            showLegendsInRow: false,
                            legendPosition: LegendPosition.bottom,
                            showLegends: true,
                            legendTextStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          chartValuesOptions: ChartValuesOptions(
                            showChartValueBackground: true,
                            showChartValues: true,
                            showChartValuesInPercentage: false,
                            showChartValuesOutside: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: screenHeight * 0.5,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("testQuestions")
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
                        if (question.get("isApprovedByAdmin")) {
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
                            quizName: widget.quizName,
                            question: questionTest,
                            option1: _options[0],
                            option2: _options[1],
                            option3: _options[2],
                            option4: _options[3],
                            correct: correct,
                          );

                          questionsWidgets.add(questionWidget);
                        }
                      }
                      return SingleChildScrollView(
                          child: (Column(children: questionsWidgets)));
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
