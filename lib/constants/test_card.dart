import 'package:flutter/material.dart';
import '../Screens/Test/questions_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TestCard extends StatefulWidget {
  final String testName;
  final String subjectName;
  bool isAvailable = true;
  TestCard({this.testName, this.subjectName});
  @override
  _TestCardState createState() => _TestCardState();
}

class _TestCardState extends State<TestCard> {
  bool _isAttempted = false;
  var _uid = FirebaseAuth.instance.currentUser != null
      ? FirebaseAuth.instance.currentUser.uid
      : "";

  void isAttempted() async {
    await FirebaseFirestore.instance
        .collection("attemptedTest")
        .doc(_uid)
        .collection(widget.testName)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                setState(() {
                  if (doc['testName'] != null || doc['testName'] != "") {
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
        if (_isAttempted) {
            Fluttertoast.showToast(
              toastLength: Toast.LENGTH_LONG,
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
              subtitle: Text("${widget.subjectName}"),
            
              title: widget.isAvailable
                  ? Text("${widget.testName}")
                  : Text("${widget.testName}- Not Available",
                      style: TextStyle(fontSize: 30.0)),
            )),
          ),
        ));
  }
}

// class TestCard extends StatelessWidget {
//   TestCard({this.testName, this.subjectName});
//   final String testName;
//   final String subjectName;
//   bool isAvailable = true;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//         onTap: () {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => QuestionsList(
//                         subjectName: subjectName,
//                         testname: testName,
//                       )));
//         },
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Container(
//             decoration: BoxDecoration(
//                 border: Border(
//                     right: BorderSide(color: Colors.black, width: 2.0),
//                     left: BorderSide(color: Colors.black, width: 2.0),
//                     top: BorderSide(color: Colors.black, width: 2.0),
//                     bottom: BorderSide(color: Colors.black, width: 2.0))),
//             child: (ListTile(
//               title: isAvailable
//                   ? Text("$testName")
//                   : Text("$testName- Not Available",
//                       style: TextStyle(fontSize: 30.0)),
//             )),
//           ),
//         ));
//   }
// }
