import 'package:flutter/material.dart';
import '../Screens/Test/SingleSubject.dart';

class SubjectCard extends StatelessWidget {
  SubjectCard({this.category,this.subject, this.num1});

  final String subject;
  final String num1;
  final String category;
  bool isAvailable = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SingleSubject(
                      category: category,
                      subjectName: subject,
                      numOfTests: int.parse(num1),
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
                ? int.parse(num1)<= 1
                    ? Text(
                        "$subject ",
                        style: TextStyle(fontSize: 22.0),
                      )
                    : Text(
                        "$subject ",
                        style: TextStyle(fontSize: 22.0),
                      )
                : Text("$subject- Not Available",
                    style: TextStyle(fontSize: 30.0)),
          )),
        ),
      ),
    );
  }
}
