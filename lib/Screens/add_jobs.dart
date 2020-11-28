import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddJobs extends StatefulWidget {
  String uid;
  String uName;
  AddJobs({this.uid, this.uName});
  @override
  _AddJobsState createState() => _AddJobsState();
}

class _AddJobsState extends State<AddJobs> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _jobType = "";
  String _orgName = "";
  String _jobDesc = "";
  String _jobSubject = "";
  String _jobSkills = "";
  int _jobPosts = 0;
  String _salary = "";
  String _orgLink = "";
  void _submitForm() async {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      showMessage('Form is not valid!  Please review and correct.');
    } else {
      form.save();
    }
    _uploadJob();
    Navigator.pop(context);
  }

  Future<void> _uploadJob() async {
    await FirebaseFirestore.instance.collection("jobs").add({
      'isApprovedByAdmin': false,
      'organizationName': _orgName,
      'jobSubject': _jobSubject,
      'jobSelectionProcedure': _jobDesc,
      'noOfPosts': _jobPosts,
      'jobSalary': _salary,
      'jobType': _jobType,
      'qualificationsRequired': _jobSkills,
      'postedBy': widget.uid,
      'posetedByName': widget.uName,
      'organizationLink': _orgLink
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
                      val.isEmpty ? 'Job Type is required' : null,
                  onSaved: (val) => _jobType = val,
                  decoration: InputDecoration(
                    icon: Icon(Icons.merge_type),
                    hintText: 'Enter the type of the job',
                    labelText: 'Job Type',
                  ),
                ),
                TextFormField(
                  inputFormatters: [LengthLimitingTextInputFormatter(30)],
                  validator: (val) =>
                      val.isEmpty ? 'Organization name is required' : null,
                  onSaved: (val) => _orgName = val,
                  decoration: InputDecoration(
                    icon: Icon(Icons.build),
                    hintText: 'Enter the name of organization',
                    labelText: 'Organization Name',
                  ),
                ),
                TextFormField(
                  inputFormatters: [LengthLimitingTextInputFormatter(30)],
                  validator: (val) =>
                      val.isEmpty ? 'Job subject is required' : null,
                  onSaved: (val) => _jobSubject = val,
                  decoration: InputDecoration(
                    icon: Icon(Icons.subject),
                    hintText: 'Enter the subject of job',
                    labelText: 'Job Subject',
                  ),
                ),
                TextFormField(
                  validator: (val) =>
                      val.isEmpty ? 'Selection procedure is required' : null,
                  onSaved: (val) => _jobDesc = val,
                  decoration: InputDecoration(
                    icon: Icon(Icons.description),
                    hintText: 'Enter the selection procedure',
                    labelText: 'Selection Procedure',
                  ),
                ),
                TextFormField(
                  validator: (val) =>
                      val.isEmpty ? 'Qualifications is required' : null,
                  onSaved: (val) => _jobSkills = val,
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'Enter the qualifications required for the job',
                    labelText: 'Qualifications',
                  ),
                ),
                TextFormField(
                  validator: (val) =>
                      val.isEmpty ? 'No. of posts is required' : null,
                  onSaved: (val) => _jobPosts = int.parse(val),
                  decoration: InputDecoration(
                    icon: Icon(Icons.confirmation_number),
                    hintText: 'Enter the number of posts available',
                    labelText: 'No of posts',
                  ),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  validator: (val) =>
                      val.isEmpty ? 'Payscale is required' : null,
                  onSaved: (val) => _salary = val,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    icon: Icon(Icons.attach_money),
                    hintText: 'Enter the payscale',
                    labelText: 'Salary/ month',
                  ),
                ),
                TextFormField(
                  validator: (val) =>
                      val.isEmpty ? 'Organization link is required' : null,
                  onSaved: (val) => _orgLink = val,
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(
                    icon: Icon(Icons.link),
                    hintText: 'Enter the organization link',
                    labelText: 'Link',
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(left: 40.0, top: 20.0),
                    child: RaisedButton(
                      child: Text('Submit job for approval'),
                      onPressed: _submitForm,
                    )),
              ],
            ),
          ),
        ));
  }
}
