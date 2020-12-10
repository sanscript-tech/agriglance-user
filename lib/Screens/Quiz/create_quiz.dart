import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
    var _questions = new List<String>(numOfQues);
    var _options1 = new List<String>(numOfQues);
    var _options2 = new List<String>(numOfQues);
    var _options3 = new List<String>(numOfQues);
    var _options4 = new List<String>(numOfQues);
    var _rightOption=new List<String>(numOfQues);

    return Scaffold(
        appBar: AppBar(
          title: Text("Create Quiz"),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Form(
          key: _formKey,
          child: Column(children: <Widget>[
            Text("Subject type and quiz name"),
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
            TextFormField(
              // ignore: deprecated_member_use
              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],

              keyboardType: TextInputType.number,
              controller: eCtrl,

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
                      return Container(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                decoration:
                                    InputDecoration(hintText: "Enter Question"),
                                validator: (val) =>
                                    val.isEmpty ? "question is required" : null,
                                onSaved: (val) => _questions[index] = val,
                              ),
                              Row(
                                children: <Widget>[
                                  TextFormField(
                                    decoration: InputDecoration(
                                        hintText: "Enter option a"),
                                    validator: (val) => val.isEmpty
                                        ? "option is required"
                                        : null,
                                    onSaved: (val) => _options1[index] = val,
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        hintText: "Enter option b"),
                                    validator: (val) => val.isEmpty
                                        ? "option is required"
                                        : null,
                                    onSaved: (val) => _options2[index] = val,
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  TextFormField(
                                    decoration: InputDecoration(
                                        hintText: "Enter option c"),
                                    validator: (val) => val.isEmpty
                                        ? "option is required"
                                        : null,
                                    onSaved: (val) => _options3[index] = val,
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        hintText: "Enter option d"),
                                    validator: (val) => val.isEmpty
                                        ? "option is required"
                                        : null,
                                    onSaved: (val) => _options4[index] = val,
                                  ),
                                ],
                              ),

                              Center(
                                child: TextFormField(
                                   decoration: InputDecoration(
                                        hintText: "Enter correct answer"),
                                    validator: (val) => val.isEmpty
                                        ? "option is required"
                                        : null,
                                    onSaved: (val) => _rightOption[index] = val,

                                ),

                              ),
                            ],
                          ),
                        ),
                      );
                    }))
          ]),
        )));
  }
}
