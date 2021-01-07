import 'package:agriglance/Screens/Test/test_home.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants/subject_card.dart';

class TestSubject extends StatefulWidget {
  String category;

  TestSubject({this.category});

  

  @override
  _TestSubjectState createState() => _TestSubjectState();
}

class _TestSubjectState extends State<TestSubject> {
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
          child: Center(
        child: Container(
          width: 700.0,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 25.0, // soften the shadow
              spreadRadius: 5.0, //extend the shadow
              offset: Offset(
                15.0,
                15.0,
              ),
            )
          ], color: Colors.yellow[50], border: Border.all(color: Colors.white)),
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
                stream: FirebaseFirestore.instance
                    .collection("testCategories")
                    .doc(widget.category)
                    .collection("subjects")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text("Loading");
                  }
                  final tests = snapshot.data.docs;
                  List<SubjectCard> testWidgets = [];
                  for (var test in tests) {
                    final testSubject = test.get('subject').toString();
                    //final numOfTests = test.get('numOfTests').toString();

                    final testWidget = SubjectCard(
                        category: widget.category,
                        subject: testSubject,
                        num1: "0");
                    testWidgets.add(testWidget);
                  }
                  return ListView(children: testWidgets);
                },
              )),
            ],
          ),
        ),
      )),
    );
  }
}

// int getNumTests(testSubject) {
//   int numTests = 0;
//   if (testSubject != "") {
//     numTests = getNumOfTest(testSubject) as int;
//   }
//   return numTests;
// }

// Future<int> getNumOfTest(testSubject) async {
//   int numTests = 0;
//   await FirebaseFirestore.instance
//       .collection("testSubjects")
//       .doc(testSubject)
//       .get()
//       .then((DocumentSnapshot documentSnapshot) => {
//             if (documentSnapshot.exists)
//               numTests = documentSnapshot.get(FieldPath(["numOfTests"]))
//           });

//   return numTests;
// }

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
