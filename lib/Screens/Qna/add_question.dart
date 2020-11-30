import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddQuestionScreen extends StatefulWidget {
  String uid;
  String uName;
  AddQuestionScreen({this.uid, this.uName});
  @override
  _AddQuestionScreenState createState() => _AddQuestionScreenState();
}

class _AddQuestionScreenState extends State<AddQuestionScreen> {
  String _category = "";
  String _question = "";
  String _questionDesc = "";
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _submitForm() async {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      showMessage('Form is not valid!  Please review and correct.');
    } else {
      form.save();
    }
    _uploadQuestion();
    Navigator.pop(context);
  }

  Future<void> _uploadQuestion() async {
    await FirebaseFirestore.instance.collection("qna").add({
      'categoryType': _category,
      'question': _question,
      'questionDesc': _questionDesc,
      'postedBy': widget.uid,
      'postedByName': widget.uName,
    });
  }

  void showMessage(String message, [MaterialColor color = Colors.red]) {
    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Question"),
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
                      val.isEmpty ? 'Question Category is required' : null,
                  onSaved: (val) => _category = val,
                  decoration: InputDecoration(
                    icon: Icon(Icons.category),
                    hintText: 'Enter the category of question',
                    labelText: 'Question Category',
                  ),
                ),
                TextFormField(
                  inputFormatters: [LengthLimitingTextInputFormatter(30)],
                  validator: (val) =>
                      val.isEmpty ? 'Question title is required' : null,
                  onSaved: (val) => _question = val,
                  decoration: InputDecoration(
                    icon: Icon(Icons.question_answer),
                    hintText: 'Enter the title of question',
                    labelText: 'Question',
                  ),
                ),
                TextFormField(
                  inputFormatters: [LengthLimitingTextInputFormatter(30)],
                  validator: (val) =>
                      val.isEmpty ? 'Question description is required' : null,
                  onSaved: (val) => _questionDesc = val,
                  decoration: InputDecoration(
                    icon: Icon(Icons.subject),
                    hintText: 'Enter the description of question',
                    labelText: 'Question Description',
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(left: 40.0, top: 20.0),
                    child: RaisedButton(
                      child: Text('Add Question'),
                      onPressed: _submitForm,
                    )),
              ],
            ),
          ),
        ));
  }
}
