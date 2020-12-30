import 'package:flutter/material.dart';
import '../Screens/Quiz/quiz_question_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class QuizCard extends StatefulWidget {
  QuizCard({this.quizName, this.uid, this.currentUser, this.uname});
  final String quizName;
  final String uid;
  final String currentUser;
  final String uname;
  bool isAvailable = true;
  @override
  _QuizCardState createState() => _QuizCardState();
}

class _QuizCardState extends State<QuizCard> {
  bool _isAttempted = false;
  var _uid = FirebaseAuth.instance.currentUser != null
      ? FirebaseAuth.instance.currentUser.uid
      : "";

  void isAttempted() async {
    await FirebaseFirestore.instance
        .collection("attemptedQuiz")
        .doc(_uid)
        .collection(widget.quizName)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                setState(() {
                  if (doc['quizName'] != null || doc['quizName'] != "") {
                    setState(() {
                      _isAttempted = true;
                    });
                  }
                });
              })
            });
  }

  @override
  void initState() {
    // TODO: implement initState
    isAttempted();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (widget.uid == widget.currentUser) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    "You can't attempt the quiz as the quiz is created by you.")));
          } else if (_isAttempted) {
            Fluttertoast.showToast(
                msg: "You have already attempted this quiz",
                gravity: ToastGravity.BOTTOM);
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => QuizQuestions(
                          quizName: widget.quizName,
                        )));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                border: Border(
                    right: BorderSide(color: Colors.black, width: 2.0),
                    left: BorderSide(color: Colors.black, width: 2.0),
                    top: BorderSide(color: Colors.black, width: 2.0),
                    bottom: BorderSide(color: Colors.black, width: 2.0))),
            child: (ListTile(
              subtitle: widget.uname != "" || widget.uname != null
                  ? Text("Created by ${widget.uname}")
                  : Text("Created by Admin"),
              title: widget.isAvailable
                  ? Text("${widget.quizName}")
                  : Text("${widget.quizName}- Not Available",
                      style: TextStyle(fontSize: 30.0)),
            )),
          ),
        ));
  }
}
