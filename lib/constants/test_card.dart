import 'package:flutter/material.dart';
import '../Screens/Test/questions_list.dart';

class TestCard extends StatelessWidget {
  TestCard({this.testName, this.subjectName});
  final String testName;
  final String subjectName;
  bool isAvailable = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => QuestionsList(
                        subjectName: subjectName,
                        testname: testName,
                      )));
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
              title: isAvailable
                  ? Text("$testName")
                  : Text("$testName- Not Available",
                      style: TextStyle(fontSize: 30.0)),
            )),
          ),
        ));
  }
}
