import 'package:flutter/material.dart';

class TestQuestions extends StatefulWidget {
  String testName;
  String subjectName;
  @override
  _TestQuestionsState createState() => _TestQuestionsState();
}

class _TestQuestionsState extends State<TestQuestions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subjectName +" "+ widget.testName),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Column(
              children: <Widget>[
                Text("question"),
                 Text("option 1"),
                  Text("option 2"),
                   Text("option 3"),
                    Text("option 4"),


              ],
            ),
          ),
        ],
        
      ),
    );
  }
}
