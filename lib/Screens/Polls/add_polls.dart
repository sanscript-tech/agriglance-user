import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddPoll extends StatelessWidget {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _question = "";
  String _option1 = "";
  String _option2 = "";
  String _option3 = "";
  String _option4 = "";
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
              ],
            ),
          ),
        ));
  }
}
