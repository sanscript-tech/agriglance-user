import 'package:agriglance/Screens/Qna/add_question.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class QnaHome extends StatefulWidget {
  @override
  _QnaHomeState createState() => _QnaHomeState();
}

class _QnaHomeState extends State<QnaHome> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddQuestionScreen(
                    uid: auth.currentUser.uid,
                    uName: auth.currentUser.displayName))),
      ),
    );
  }
}
