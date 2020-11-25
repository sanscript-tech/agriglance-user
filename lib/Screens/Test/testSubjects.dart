import 'package:flutter/material.dart';

class TestSubject extends StatefulWidget {
  @override
  _TestSubjectState createState() => _TestSubjectState();
}

class _TestSubjectState extends State<TestSubject> {
  List<String> subjects = [];

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
                "IPS 2020",
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
              child: ListView(shrinkWrap: true, children: <Widget>[
            _getSubjects("History", 22),
            _getSubjects("English", 29),
            _getSubjects("English", 29),
            _getSubjects("English", 29),
            _getSubjects("English", 29),
            _getSubjects("English", 29),
            _getSubjects("English", 29),
            _getSubjects("English", 29),
            _getSubjects("English", 29),
            _getSubjects("English", 29),
            _getSubjects("English", 29),
            _getSubjects("English", 29),
            _getSubjects("English", 29),
          ])),
        ],
      )),
    );
  }
}

Widget _getSubjects(String subject, int num) {
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
                "$subject - $num Test Available",
                style: TextStyle(fontSize: 22.0),
              )
            : Text("$subject- Not Available", style: TextStyle(fontSize: 30.0)),
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
