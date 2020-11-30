import 'package:flutter/material.dart';

class SingleSubject extends StatefulWidget {
  String subjectName;
  int numOfTests;
  SingleSubject({this.subjectName,this.numOfTests});

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
          child: Icon(Icons.add),
          backgroundColor: Colors.amber,
          onPressed: () {}),
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
                  "History Test",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "Roboto",
                      fontSize: screenHeight * 0.035),
                ),
              ),
              Expanded(
                  child: ListView(shrinkWrap: true, children: <Widget>[
                _getSubjectDetails(1, 30, "Admin"),
                _getSubjectDetails(2, 30, "Swarup"),
                _getSubjectDetails(2, 30, "Swarup"),
                _getSubjectDetails(2, 30, "Swarup"),
                _getSubjectDetails(2, 30, "Swarup"),
                _getSubjectDetails(2, 30, "Swarup"),
                _getSubjectDetails(2, 30, "Swarup"),
                _getSubjectDetails(2, 30, "Swarup"),
                _getSubjectDetails(2, 30, "Swarup"),
                _getSubjectDetails(2, 30, "Swarup"),
                _getSubjectDetails(2, 30, "Swarup"),
              ])),
            ],
          )),
    );
  }
}

Widget _getSubjectDetails(int testNumber, int numQuestions, String creator) {
  bool isAvailable = true;
  // if (num == 0 || num <= 0) {
  //   isAvailable = false;
  // }
  return Padding(
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
                "Test-$testNumber. $numQuestions Questions \n by $creator",
                style: TextStyle(fontSize: 22.0),
              )
            : Text("$testNumber- Not Available",
                style: TextStyle(fontSize: 30.0)),
      )),
    ),
  );
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
