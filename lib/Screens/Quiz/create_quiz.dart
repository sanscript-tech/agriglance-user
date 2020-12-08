import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final TextEditingController eCtrl = new TextEditingController();
  String _quizSubject = "";
  int time = 0;
  int numOfQues = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Create Quiz"),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Form(
          key: _formKey,
          child: Column(children: <Widget>[
            Text("Subject type"),
            TextFormField(
              inputFormatters: [LengthLimitingTextInputFormatter(30)],
              validator: (val) =>
                  val.isEmpty ? 'Quiz subject is required' : null,
              onSaved: (val) => _quizSubject = val,
              decoration: InputDecoration(
                icon: Icon(Icons.book_rounded),
                hintText: 'Enter the subject',
                labelText: 'Subject',
              ),
            ),
            Text("Time Limit"),
            TextFormField(
              inputFormatters: [LengthLimitingTextInputFormatter(30)],
              validator: (val) => val.isEmpty ? 'Time Limit is required' : null,
              onSaved: (val) => time = int.parse(val),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter the time limit',
                labelText: 'Time',
              ),
            ),
            Text("Number of questions"),
            TextField(
              keyboardType:TextInputType.number,
              controller: eCtrl,
              onSubmitted: (val) {
                numOfQues = int.parse(val);
              },
              onChanged: (value) {
                setState(() {
                  numOfQues = int.parse(value);
                });
              },
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: numOfQues,
                    itemBuilder: (BuildContext context, int index) {
                      return Text("dv");
                    }))
          ]),
        )));
  }
}

class QuizData extends ChangeNotifier {
  String _ques = "";
  String _option1 = "";
  String _option2 = "";
  String _option3 = "";
  String _option4 = "";
  String _rightAns = "";
}
