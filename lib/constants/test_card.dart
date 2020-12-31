import 'package:flutter/material.dart';
import '../Screens/Test/questions_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TestCard extends StatefulWidget {
  final String testName;
  final String subjectName;
  TestCard({this.testName,this.subjectName});
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
  Widget build(BuildContext context) {
    return Container();
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
