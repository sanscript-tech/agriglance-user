import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  final _uid = FirebaseAuth.instance.currentUser.uid;
  final _uname = FirebaseAuth.instance.currentUser.displayName;
  bool _isApproved = false;
  bool isAvailable = false;

  String _quizSubject = "";
  int time = 0;
  int numOfQues = 0;

  String _ques = "";
  String _option1 = "";
  String _option2 = "";
  String _option3 = "";
  String _option4 = "";
  String _rightAnswer = "";

  final TextEditingController eCtrl = new TextEditingController();
  final myController = TextEditingController();

  Future<void> isQuizAvailable(String name) async {
    List<String> test_names = [];

    await FirebaseFirestore.instance
        .collection("QuizTestName")
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                test_names.add(doc["quizName"]);
              })
            });

    for (var test in test_names) {
      if (test == name) {
        setState(() {
          isAvailable = true;
        });
        break;
      }
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Create Quiz"),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Column(children: <Widget>[
          Text("Subject type and quiz name"),
          TextFormField(
            inputFormatters: [LengthLimitingTextInputFormatter(30)],
            validator: (val) => val.isEmpty ? 'Quiz subject is required' : null,
            onChanged: (val) {
              setState(() {
                _quizSubject = val;
              });
            },
          ),
          Text("Time Limit"),
          TextFormField(
            inputFormatters: [LengthLimitingTextInputFormatter(30)],
            validator: (val) => val.isEmpty ? 'Time Limit is required' : null,
            onChanged: (val) {
              setState(() {
                time = int.parse(val);
              });
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Enter the time limit',
              labelText: 'Time',
            ),
          ),
          Text("Number of questions"),
          TextFormField(
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
                  final GlobalKey<FormState> _formKey =
                      new GlobalKey<FormState>();
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              decoration:
                                  InputDecoration(labelText: "Enter Question"),
                              validator: (val) =>
                                  val.isEmpty ? "question is required" : null,
                              onSaved: (val) {
                                _ques = val;
                              },
                            ),
                            TextFormField(
                                decoration:
                                    InputDecoration(labelText: "option a"),
                                validator: (val) =>
                                    val.isEmpty ? "option is required" : null,
                                onSaved: (val) {
                                  setState(() {
                                    _option1 = val;
                                  });
                                }),
                            TextFormField(
                              decoration:
                                  InputDecoration(labelText: "option b"),
                              validator: (val) =>
                                  val.isEmpty ? "option is required" : null,
                              onSaved: (val) {
                                setState(() {
                                  _option2 = val;
                                });
                              },
                            ),
                            TextFormField(
                                decoration:
                                    InputDecoration(labelText: "option c"),
                                validator: (val) =>
                                    val.isEmpty ? "option is required" : null,
                                onSaved: (val) {
                                  setState(() {
                                    _option3 = val;
                                  });
                                }),
                            TextFormField(
                                decoration:
                                    InputDecoration(labelText: "option d"),
                                validator: (val) =>
                                    val.isEmpty ? "option is required" : null,
                                onSaved: (val) {
                                  setState(() {
                                    _option4 = val;
                                  });
                                }),
                            TextFormField(
                                decoration: InputDecoration(
                                    labelText: "correct answer"),
                                validator: (val) =>
                                    val.isEmpty ? "option is required" : null,
                                onSaved: (val) {
                                  setState(() {
                                    _rightAnswer = val;
                                  });
                                }),
                            RaisedButton(
                              child: Text("Submit"),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  isQuizAvailable(_quizSubject);
                                  if (isAvailable) {
                                    await FirebaseFirestore.instance
                                        .collection("QuizTestName")
                                        .doc(_quizSubject)
                                        .collection("questions")
                                        .add({
                                      "ques": _ques,
                                      "option1": _option1,
                                      "option2": _option2,
                                      "option3": _option3,
                                      "option4": _option4,
                                      "correct": _rightAnswer
                                    });
                                  } else {
                                    await FirebaseFirestore.instance
                                        .collection("QuizTestName")
                                        .doc(_quizSubject)
                                        .set({
                                      "quizName": _quizSubject,
                                      "quizTime": time,
                                      "isApprovedByAdmin": _isApproved,
                                      "uid": _uid,
                                      "uname": _uname
                                    });
                                    await FirebaseFirestore.instance
                                        .collection("QuizTestName")
                                        .doc(_quizSubject)
                                        .collection("questions")
                                        .add({
                                      "ques": _ques,
                                      "option1": _option1,
                                      "option2": _option2,
                                      "option3": _option3,
                                      "option4": _option4,
                                      "correct": _rightAnswer
                                    });
                                  }

                                  setState(() {
                                    numOfQues -= 1;
                                  });
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ])));
  }
}
