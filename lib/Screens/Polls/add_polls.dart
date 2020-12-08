import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddPoll extends StatefulWidget {
  @override
  _AddPollState createState() => _AddPollState();
}

class _AddPollState extends State<AddPoll> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final FirebaseAuth auth = FirebaseAuth.instance;

  String _question = "";

  String _option1 = "";

  String _option2 = "";

  String _option3 = "";

  String _option4 = "";

  void _submitForm() async {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      showMessage('Form is not valid!  Please review and correct.');
    } else {
      form.save();
    }
    _createPoll();
    Navigator.pop(context);
  }

  void showMessage(String message, [MaterialColor color = Colors.red]) {
    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
  }

  Future<void> _createPoll() async {
    await FirebaseFirestore.instance.collection("polls").add({
      'isApprovedByAdmin': false,
      'voters': [],
      'question': _question,
      'option1': _option1,
      'totalVotesOnOption1': 0,
      'option2': _option2,
      'totalVotesOnOption2': 0,
      'option3': _option3,
      'totalVotesOnOption3': 0,
      'option4': _option4,
      'totalVotesOnOption4': 0,
      'postedByName':auth.currentUser.displayName,
      'createdOn':DateTime.now()
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Create Polls"),
          centerTitle: true,
        ),
        body: SafeArea(
          top: false,
          bottom: false,
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                TextFormField(
                  inputFormatters: [LengthLimitingTextInputFormatter(30)],
                  validator: (val) =>
                      val.isEmpty ? 'Question cannot be empty' : null,
                  onSaved: (val) => _question = val,
                  decoration: InputDecoration(
                    icon: Icon(Icons.question_answer),
                    hintText: 'Enter question',
                    labelText: 'Question',
                  ),
                ),
                TextFormField(
                  inputFormatters: [LengthLimitingTextInputFormatter(30)],
                  validator: (val) =>
                      val.isEmpty ? 'Option 1 cannot be empty' : null,
                  onSaved: (val) => _option1 = val,
                  decoration: InputDecoration(
                    icon: Icon(Icons.poll),
                    hintText: 'Enter option 1 of poll',
                    labelText: 'Option 1',
                  ),
                ),
                TextFormField(
                  inputFormatters: [LengthLimitingTextInputFormatter(30)],
                  validator: (val) =>
                      val.isEmpty ? 'Option 2 cannot be empty' : null,
                  onSaved: (val) => _option2 = val,
                  decoration: InputDecoration(
                    icon: Icon(Icons.poll),
                    hintText: 'Enter option 2 of poll',
                    labelText: 'Option 2',
                  ),
                ),
                TextFormField(
                  inputFormatters: [LengthLimitingTextInputFormatter(30)],
                  validator: (val) =>
                      val.isEmpty ? 'Option 3 cannot be empty' : null,
                  onSaved: (val) => _option3 = val,
                  decoration: InputDecoration(
                    icon: Icon(Icons.poll),
                    hintText: 'Enter option 3 of poll',
                    labelText: 'Option 3',
                  ),
                ),
                TextFormField(
                  inputFormatters: [LengthLimitingTextInputFormatter(30)],
                  validator: (val) =>
                      val.isEmpty ? 'Option 4 cannot be empty' : null,
                  onSaved: (val) => _option4 = val,
                  decoration: InputDecoration(
                    icon: Icon(Icons.poll),
                    hintText: 'Enter option 4 of poll',
                    labelText: 'Option 4',
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(left: 40.0, top: 20.0),
                    child: RaisedButton(
                      child: Text('Create Poll'),
                      onPressed: _submitForm,
                    )),
              ],
            ),
          ),
        ));
  }
}
