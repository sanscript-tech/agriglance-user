import 'package:agriglance/Services/authentication_service.dart';
import 'package:agriglance/Services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key key}) : super(key: key);
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Profile"),
      ),
      body: Center(
        child: FutureBuilder(
            future: _firestoreService
                .getUser(FirebaseAuth.instance.currentUser.uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return displayUserInformation(context, snapshot);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }

  Widget displayUserInformation(BuildContext context, AsyncSnapshot snapshot) {
    final userData = snapshot.data;
    final TextStyle defaultStyle =
        TextStyle(color: Colors.grey, fontSize: 20.0);
    final TextStyle valueStyle = TextStyle(color: Colors.black, fontSize: 20.0);
    final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    String _fullName = "";
    String _emailId = "";
    String _dob = "";
    String _qualification = "";
    String _university = "";
    int points = userData.points;
    void showMessage(String message, [MaterialColor color = Colors.red]) {
      _scaffoldKey.currentState.showSnackBar(
          new SnackBar(backgroundColor: color, content: new Text(message)));
    }

    Future _updateProfile() {
      context.read<AuthenticationService>().editProfile(
          _emailId, _fullName, _dob, _qualification, _university, points);
    }

    void _submitForm() async {
      final FormState form = _formKey.currentState;
      if (!form.validate()) {
        showMessage('Form is not valid!  Please review and correct.');
      } else {
        form.save();
      }
      _updateProfile();
      Navigator.pop(context);
    }

    return SafeArea(
        child: Container(
      width: 400.0,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 25.0, // soften the shadow
          spreadRadius: 5.0, //extend the shadow
          offset: Offset(
            15.0,
            15.0,
          ),
        )
      ], color: Colors.amber[100], border: Border.all(color: Colors.white)),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (val) => val.isEmpty ? 'FullName is required' : null,
                onSaved: (val) => _fullName = val,
                initialValue: userData.fullName,
                decoration: InputDecoration(
                    hintText: 'Full Name',
                    icon: Icon(Icons.person),
                    labelText: "Full Name"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (val) => val.isEmpty ? 'Email is required' : null,
                onSaved: (val) => _emailId = val,
                initialValue: userData.email,
                decoration: InputDecoration(
                    hintText: 'Email Id',
                    icon: Icon(Icons.email),
                    labelText: "Email Id"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (val) => val.isEmpty ? 'DOB is required' : null,
                onSaved: (val) => _dob = val,
                initialValue: userData.dob,
                decoration: InputDecoration(
                    hintText: 'DOB',
                    icon: Icon(Icons.date_range),
                    labelText: "Date of Birth"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (val) =>
                    val.isEmpty ? 'Qualification is required' : null,
                onSaved: (val) => _qualification = val,
                initialValue: userData.qualification,
                decoration: InputDecoration(
                    hintText: 'Qualification',
                    icon: Icon(Icons.grade),
                    labelText: "Educational Qualification"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (val) =>
                    val.isEmpty ? 'University is required' : null,
                onSaved: (val) => _university = val,
                initialValue: userData.university,
                decoration: InputDecoration(
                    hintText: 'University',
                    icon: Icon(Icons.account_balance),
                    labelText: "University"),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: RaisedButton(
                splashColor: Colors.grey,
                color: Colors.yellow,
                onPressed: () {
                  _submitForm();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                highlightElevation: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
