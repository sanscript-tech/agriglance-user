import 'package:agriglance/Screens/Test/add_questions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddTest extends StatefulWidget {
  String testSubject;
  AddTest({this.testSubject});
  @override
  _AddTestState createState() => _AddTestState();
}

class _AddTestState extends State<AddTest> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _testName = "";
  String _testDescription = "";
  String _image = "";

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
                        _formKey.currentState.save();

                        if (_formKey.currentState.validate()) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddQuestions(testName: _testName,)));
                        }
                      })),
            ]),
          )),
    );
  }
}
