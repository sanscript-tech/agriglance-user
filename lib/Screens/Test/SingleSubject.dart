import 'package:agriglance/Screens/Test/add_test.dart';
import 'package:agriglance/Screens/Test/questions_list.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants/test_card.dart';

class SingleSubject extends StatefulWidget {
  String subjectName;
  int numOfTests;
  String category;
  SingleSubject({this.category,this.subjectName, this.numOfTests});

  @override
  _SingleSubjectState createState() => _SingleSubjectState();
}

class _SingleSubjectState extends State<SingleSubject> {
  List<String> subjects = [];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          tooltip: "Add test",
          child: Column(
            children: <Widget>[
              Icon(
                Icons.add,
                size: 40.0,
              ),
              Text(
                "Add Test",
                style: TextStyle(fontSize: 10.0),
              ),
            ],
          ),
          backgroundColor: Colors.amber,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddTest(
                      category: widget.category,
                          testSubject: widget.subjectName,
                        )));
          }),
      appBar: AppBar(
        title: Text("Agriglance"),
        centerTitle: true,
      ),
      body: SafeArea(
          top: true,
          bottom: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.03),
              Container(
                child: Text(
                  widget.subjectName,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "Roboto",
                      fontSize: screenHeight * 0.035),
                ),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("testSubjects")
                      .doc(widget.subjectName)
                      .collection("testNames")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Text("Loading");
                    }

                    final testNames = snapshot.data.docs;
                    List<TestCard> testsWidgets = [];
                    for (var test in testNames) {
                      final testName = test.get('testName').toString();
                      // final numQuestions =
                      //     test.get('numOfQuestions').toString();
                      final testWidget = TestCard(
                        testName: testName,
                        subjectName: widget.subjectName,
                      );

                      testsWidgets.add(testWidget);
                    }

                    return (ListView(children: testsWidgets));
                  },
                ),
              ),
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
