import 'package:agriglance/Screens/Test/SingleSubject.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TestSubject extends StatefulWidget {
  String uid;
  String category;
  TestSubject({this.uid, this.category});
  @override
  _TestSubjectState createState() => _TestSubjectState();
}

class _TestSubjectState extends State<TestSubject> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Agriglance"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: screenHeight * 0.03),
          Container(
            child: Column(children: <Widget>[
              Text(
                widget.category + " " + "2020",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "Roboto",
                    fontSize: screenHeight * 0.04,
                    fontStyle: FontStyle.italic),
              ),
              SizedBox(height: screenHeight * 0.02),
              getSeparateDivider(),
              SizedBox(height: screenHeight * 0.02),
              Text(
                "Test Subjects",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "Roboto",
                    fontSize: screenHeight * 0.035),
              ),
              SizedBox(height: screenHeight * 0.03),
            ]),
          ),
          Expanded(
              child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("subjects").snapshots(),
                
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text("Loading");
              }
              final tests = snapshot.data.docs;
              List<SubjectCard> testWidgets = [];
              for (var test in tests) {
                final testSubject = test.get('subjectName').toString();
                final numTests = test.get('numofTestAvailable').toString();

                final testWidget = SubjectCard(
                  subject: testSubject,
                  num1: numTests,
                );
                testWidgets.add(testWidget);
              }
              return ListView(children: testWidgets);
            },
          )),
        ],
      )),
    );
  }
}

class Drawhorizontalline extends CustomPainter {
  Paint _paint;
  bool reverse;

  Drawhorizontalline(this.reverse) {
    _paint = Paint()
      ..color = Colors.black26
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(Offset(-180.0, 0.0), Offset(150.0, 0.0), _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

Widget getSeparateDivider() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      CustomPaint(painter: Drawhorizontalline(true)),
    ],
  );
}

class SubjectCard extends StatelessWidget {
  SubjectCard({this.subject, this.num1});

  final String subject;
  final String num1;
  bool isAvailable = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SingleSubject(
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
                ? Text(
                    "$subject - $num1 Tests Available",
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
