import 'package:agriglance/Services/authentication_service.dart';
import 'package:agriglance/Services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Page"),
      ),
      body: Column(
        children: [
          FutureBuilder(
              future: _firestoreService
                  .getUser(FirebaseAuth.instance.currentUser.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return displayUserInformation(context, snapshot);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ],
      ),
    );
  }

  Widget displayUserInformation(BuildContext context, AsyncSnapshot snapshot) {
    final userData = snapshot.data;
    final TextStyle defaultStyle =
        TextStyle(color: Colors.grey, fontSize: 20.0);
    final TextStyle valueStyle = TextStyle(color: Colors.black, fontSize: 20.0);

    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "FullName : ",
                  style: defaultStyle,
                ),
                Text(
                  "${userData.fullName}",
                  style: valueStyle,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Email Id : ",
                  style: defaultStyle,
                ),
                Text(
                  "${userData.email}",
                  style: valueStyle,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "DOB : ",
                  style: defaultStyle,
                ),
                Text(
                  "${userData.dob}",
                  style: valueStyle,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Educational Qualification : ",
                  style: defaultStyle,
                ),
                Text(
                  "${userData.qualification}",
                  style: valueStyle,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "University : ",
                  style: defaultStyle,
                ),
                Text(
                  "${userData.university}",
                  style: valueStyle,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: OutlineButton(
              splashColor: Colors.grey,
              onPressed: () {
                try {
                  context.read<AuthenticationService>().resetPassword(
                      FirebaseAuth.instance.currentUser.email.trim());
                  setState(() {
                    showSnack(context);
                  });
                } catch (e) {
                  print("Unsuccessful");
                }
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
              highlightElevation: 0,
              borderSide: BorderSide(color: Colors.grey),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Update Password',
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
          ),
        ],
      ),
    );
  }

  void showSnack(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(
            "Password reset link has been sent to your registered email address"),
      ),
    );
  }
}
