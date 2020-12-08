import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddPoll extends StatelessWidget {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _question = "";
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
              ],
            ),
          ),
        ));
  }
}
