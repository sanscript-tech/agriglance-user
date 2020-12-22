import 'package:agriglance/Models/usermodel.dart';
import 'package:agriglance/Services/firestore_service.dart';
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
  String _uname;
  bool _isApproved = false;
  bool isAvailable = false;
  bool _isQuestionApproved = false;

  String _quizName = "";
  int time = 0;
  int numOfQues = 0;

  String _ques = "";
  String _option1 = "";
  String _option2 = "";
  String _option3 = "";
  String _option4 = "";

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
            child: Center(
          child: Container(
            width: 700.0,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 25.0, // soften the shadow
                    spreadRadius: 5.0, //extend the shadow
                    offset: Offset(
                      15.0,
                      15.0,
                    ),
                  )
                ],
                color: Colors.yellow[50],
                border: Border.all(color: Colors.white)),
            child: Column(children: <Widget>[
              TextFormField(
                inputFormatters: [LengthLimitingTextInputFormatter(50)],
                validator: (val) =>
                    val.isEmpty ? 'Quiz subject is required' : null,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  icon: Icon(Icons.edit),
                  hintText: 'Enter quiz name',
                  labelText: 'Quiz Name',
                ),
                onChanged: (val) {
                  setState(() {
                    _quizName = val;
                  });
                },
              ),
              TextFormField(
                inputFormatters: [LengthLimitingTextInputFormatter(50)],
                validator: (val) =>
                    val.isEmpty ? 'Time Limit is required' : null,
                onChanged: (val) {
                  setState(() {
                    time = int.parse(val);
                  });
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter the time limit in seconds',
                  labelText: 'Time in seconds',
                  icon: Icon(Icons.timer_sharp),
                ),
              ),
              TextFormField(
                controller: eCtrl,
                onChanged: (value) {
                  setState(() {
                    numOfQues = int.parse(value);
                  });
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter Number of Questions',
                  labelText: 'Number of Questions',
                  icon: Icon(Icons.confirmation_number_outlined),
                ),
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
                            autovalidateMode: AutovalidateMode.always,
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  decoration: InputDecoration(
                                      labelText: "Enter Question"),
                                  validator: (val) => val.isEmpty
                                      ? "question is required"
                                      : null,
                                  onSaved: (val) {
                                    _ques = val;
                                  },
                                ),
                                TextFormField(
                                    decoration: InputDecoration(
                                        labelText: "option a(Correct Answer)"),
                                    validator: (val) => val.isEmpty
                                        ? "option is required"
                                        : null,
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
                                    validator: (val) => val.isEmpty
                                        ? "option is required"
                                        : null,
                                    onSaved: (val) {
                                      setState(() {
                                        _option3 = val;
                                      });
                                    }),
                                TextFormField(
                                    decoration:
                                        InputDecoration(labelText: "option d"),
                                    validator: (val) => val.isEmpty
                                        ? "option is required"
                                        : null,
                                    onSaved: (val) {
                                      setState(() {
                                        _option4 = val;
                                      });
                                    }),
                                RaisedButton(
                                  child: Text("Submit"),
                                  color: Colors.yellow,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  onPressed: () async {
                                    UserModel updateUser =
                                        await FirestoreService().getUser(
                                            FirebaseAuth
                                                .instance.currentUser.uid);
                                    setState(() {
                                      _uname = updateUser.fullName;
                                    });
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                      isQuizAvailable(_quizName);
                                      if (isAvailable) {
                                        await FirebaseFirestore.instance
                                            .collection("QuizTestName")
                                            .doc(_quizName)
                                            .collection("questions")
                                            .add({
                                          "ques": _ques,
                                          "option1": _option1,
                                          "option2": _option2,
                                          "option3": _option3,
                                          "option4": _option4,
                                          "isApprovedByAdmin":_isQuestionApproved
                                        });
                                      } else {
                                        await FirebaseFirestore.instance
                                            .collection("QuizTestName")
                                            .doc(_quizName)
                                            .set({
                                          "quizName": _quizName,
                                          "quizTime": time,
                                          "isApprovedByAdmin": _isApproved,
                                          "uid": _uid,
                                          "uname": _uname
                                        });
                                        await FirebaseFirestore.instance
                                            .collection("QuizTestName")
                                            .doc(_quizName)
                                            .collection("questions")
                                            .add({
                                          "ques": _ques,
                                          "option1": _option1,
                                          "option2": _option2,
                                          "option3": _option3,
                                          "option4": _option4,
                                          "isApprovedByAdmin":_isQuestionApproved
                                        
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
            ]),
          ),
        )));
  }
}
