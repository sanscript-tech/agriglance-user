import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  String _quizSubject = "";
  int time = 0;
  int numOfQues = 0;

  final TextEditingController eCtrl = new TextEditingController();
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _questions = new List<String>(numOfQues);
    var _options1 = new List<String>(numOfQues);
    var _options2 = new List<String>(numOfQues);
    var _options3 = new List<String>(numOfQues);
    var _options4 = new List<String>(numOfQues);
    var _rightOption = new List<String>(numOfQues);
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
            onChanged: (val) => _quizSubject = val,
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
            onChanged: (val) => time = int.parse(val),
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
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      child: Form(
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: myController,
                              decoration:
                                  InputDecoration(labelText: "Enter Question"),
                              // validator: (val) =>
                              // val.isEmpty ? "question is required" : null,
                              onChanged: (val) {
                               setState(() {
                                  _questions[index] = myController.text;
                               });
                              },
                            ),
                            TextFormField(
                              decoration:
                                  InputDecoration(labelText: "option a"),
                              // validator: (val) =>
                              //     val.isEmpty ? "option is required" : null,
                              onChanged: (val) {
                                setState(() {
                                  _options1[index] = val;
                                });
                              },
                            ),
                            TextFormField(
                              decoration:
                                  InputDecoration(labelText: "option b"),
                              validator: (val) =>
                                  val.isEmpty ? "option is required" : null,
                              onChanged: (val) {
                                setState(() {
                                  _options2[index] = val;
                                });
                              },
                            ),
                            TextFormField(
                              decoration:
                                  InputDecoration(labelText: "option c"),
                              // validator: (val) =>
                              //     val.isEmpty ? "option is required" : null,
                              onChanged: (val) {
                                setState(() {
                                  _options3[index] = val;
                                });
                              },
                            ),
                            TextFormField(
                              decoration:
                                  InputDecoration(labelText: "option d"),
                              // validator: (val) =>
                              //     val.isEmpty ? "option is required" : null,
                              onChanged: (val) {
                                setState(() {
                                  _options4[index] = val;
                                });
                              },
                            ),
                            TextFormField(
                              decoration:
                                  InputDecoration(labelText: "correct answer"),
                              // validator: (val) =>
                              //     val.isEmpty ? "option is required" : null,
                              onFieldSubmitted: (val) {
                                setState(() {
                                  _rightOption[index] = val;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
          RaisedButton(
            child: Text('Submit'),
            onPressed: () async {
              print(_questions);
              print(_options4);
              print(_options2);
              print(_options1);
              print(_rightOption);
            },
          ),
        ])));
  }
}
