import 'package:agriglance/Screens/Test/add_questions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddTest extends StatefulWidget {
  final String testSubject;
  final String category;

  AddTest({this.category, this.testSubject});

  @override
  _AddTestState createState() => _AddTestState();
}

class _AddTestState extends State<AddTest> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _testName = "";
  String _testDescription = "";
  String _image = "";
  bool _isApproved = false;

  void showMessage(String message, [MaterialColor color = Colors.red]) {
    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
  }

  void _submitForm() async {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      showMessage('Form is not valid!  Please review and correct.');
    } else {
      form.save();
      _uploadQuestion();
    }
  }

  Future<void> _uploadQuestion() async {
    List<String> test_names = [];
    bool isAvailable = false;
    final sample = await FirebaseFirestore.instance
        .collection("testSubjects")
        .doc(widget.testSubject)
        .collection("testNames")
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                test_names.add(doc["testName"]);
              })
            });

    //search for duplicate test name
    for (var test in test_names) {
      if (test == _testName) {
        isAvailable = true;
        break;
      }
    }

    //Adding number of tests

    // final int numOfTests = await FirebaseFirestore.instance
    //     .collection("testSubjects")
    //     .doc(widget.testSubject)
    //     .collection("testNames")
    //     .snapshots()
    //     .length;
    // print("adbhabfhasbchbashcbsachj");
    // print(numOfTests);

    if (isAvailable) {
      Fluttertoast.showToast(
          msg: "Test already exists,now add more questions in this !!!",
          gravity: ToastGravity.BOTTOM);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddQuestions(
                    testName: _testName,
                    testSubject: widget.testSubject,
                  )));
    } else {

      await FirebaseFirestore.instance
          .collection("testSubjects")
          .doc(widget.testSubject)
          .collection("testNames")
          .add({
        "testName": _testName,
        "testDescription": _testDescription,
        "testImage": _image,
        "isApprovedByAdmin": _isApproved
      });

       Fluttertoast.showToast(
         toastLength: Toast.LENGTH_LONG,
          msg: "Now add some questions !!!",
          gravity: ToastGravity.BOTTOM);



      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddQuestions(
                    testName: _testName,
                    testSubject: widget.testSubject,
                  )));
    }

    // final update = await FirebaseFirestore.instance
    //     .collection("testCategories")
    //     .doc(widget.category)
    //     .collection("subjects")
    //     .doc(widget.testSubject)
    //     .update({"numOfTests": numOfTests + 1});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Test - ${widget.testSubject}"),
        centerTitle: true,
      ),
      body: SafeArea(
          top: true,
          bottom: true,
          child: Center(
            child: Container(
              width: 700.0,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 25.0, // soften the shadow
                      spreadRadius: 5.0, //extend the shadow
                      offset: Offset(
                        15.0,
                        15.0,
                      ),
                    )
                  ],
                  color: Colors.yellow[50],
                  border: Border.all(color: Colors.white)),
              child: Form(
                key: _formKey,
                child: ListView(children: <Widget>[
                  TextFormField(
                    inputFormatters: [LengthLimitingTextInputFormatter(30)],
                    validator: (val) =>
                        val.isEmpty ? 'Test name is required' : null,
                    onSaved: (val) => _testName = val,
                    decoration: InputDecoration(
                      icon: Icon(Icons.book_rounded),
                      hintText: 'Enter the test Name',
                      labelText: 'Test Name',
                    ),
                  ),
                  TextFormField(
                    validator: (val) =>
                        val.isEmpty ? 'Test description is required' : null,
                    onSaved: (val) => _testDescription = val,
                    decoration: InputDecoration(
                      icon: Icon(Icons.description),
                      hintText: 'Enter the test description',
                      labelText: 'Description',
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(
                      child: RaisedButton(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            side: BorderSide(color: Colors.black87),
                          ),
                          splashColor: Colors.purple,
                          elevation: 10.0,
                          highlightElevation: 30.0,
                          child: const Text(
                            'Add Questions',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 20.0,
                            ),
                          ),
                          color: Colors.blue[300],
                          textColor: Colors.white,
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              _submitForm();
                            }
                          })),
                ]),
              ),
            ),
          )),
    );
  }
}
