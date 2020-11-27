import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddJobs extends StatefulWidget {
  @override
  _AddJobsState createState() => _AddJobsState();
}

class _AddJobsState extends State<AddJobs> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _jobTitle = "";
  String _jobDesc = "";
  String _jobSkills = "";
  String _jobResponsibility = "";
  String _salary = "";
  void _submitForm() async {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      showMessage('Form is not valid!  Please review and correct.');
    } else {
      form.save();
    }
    _uploadJob();
  }

  Future<void> _uploadJob() async {
    await FirebaseFirestore.instance.collection("jobs").add({
      'isApprovedByAdmin': false,
      'jobDescription': _jobDesc,
      'jobResponsibility': _jobResponsibility,
      'jobSalary': _salary,
      'jobTitle': _jobTitle,
      'skillsRequired': _jobSkills
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
          title: Text("Add Jobs"),
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
                      val.isEmpty ? 'Job Title is required' : null,
                  onSaved: (val) => _jobTitle = val,
                  decoration: InputDecoration(
                    icon: Icon(Icons.book),
                    hintText: 'Enter the title of the job',
                    labelText: 'Job Title',
                  ),
                ),
                TextFormField(
                  validator: (val) =>
                      val.isEmpty ? 'Job Description is required' : null,
                  onSaved: (val) => _jobDesc = val,
                  decoration: InputDecoration(
                    icon: Icon(Icons.description),
                    hintText: 'Enter the description of the job',
                    labelText: 'Job Description',
                  ),
                ),
                TextFormField(
                  validator: (val) => val.isEmpty ? 'Skills is required' : null,
                  onSaved: (val) => _jobSkills = val,
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'Enter the skills required for the job',
                    labelText: 'Skills',
                  ),
                ),
                TextFormField(
                  validator: (val) =>
                      val.isEmpty ? 'Job responsibility is required' : null,
                  onSaved: (val) => _jobResponsibility = val,
                  decoration: InputDecoration(
                    icon: Icon(Icons.line_weight),
                    hintText: 'Enter the job responsibilty',
                    labelText: 'Job Responsibility',
                  ),
                ),
                TextFormField(
                  validator: (val) => val.isEmpty ? 'Salary is required' : null,
                  onSaved: (val) => _salary = val,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    icon: Icon(Icons.attach_money),
                    hintText: 'Enter the salary offered',
                    labelText: 'Salary',
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(left: 40.0, top: 20.0),
                    child: RaisedButton(
                      child: Text('Add Job'),
                      onPressed: _submitForm,
                    )),
              ],
            ),
          ),
        ));
  }
}
