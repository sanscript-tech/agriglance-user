import 'package:agriglance/Screens/Home/Drawer/my_jobs.dart';
import 'package:agriglance/Screens/Home/Drawer/my_poll.dart';
import 'package:agriglance/Screens/Home/Drawer/my_questions.dart';
import 'package:agriglance/Screens/Home/Drawer/my_quiz.dart';
import 'package:agriglance/Screens/Home/Drawer/my_study_materials.dart';
import 'package:agriglance/Screens/Home/Drawer/my_videos.dart';
import 'package:agriglance/Services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Profile/profile.dart';
import '../Profile/update_profile.dart';

class DrawerWindow extends StatefulWidget {
  @override
  _DrawerWindowState createState() => _DrawerWindowState();
}

class _DrawerWindowState extends State<DrawerWindow> {
  FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:
            _firestoreService.getUser(FirebaseAuth.instance.currentUser.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return drawerWidget(context, snapshot);
          } else {
            return Container(child: Center(child: CircularProgressIndicator()));
          }
        });
  }

  Widget drawerWidget(BuildContext context, AsyncSnapshot snapshot) {
    final userData = snapshot.data;
    return Drawer(
      elevation: 10.0,
      child: ListView(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()));
            },
            child: UserAccountsDrawerHeader(
              accountName: Text(
                userData.fullName,
                style: TextStyle(fontSize: 20.0),
              ),
              accountEmail: Text(userData.email),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text(
                  userData.fullName[0],
                  style: TextStyle(fontSize: 40.0, color: Colors.black),
                ),
              ),
            ),
          ),
          ListTile(
            trailing: Icon(Icons.edit),
            title: Text("Update Profile"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UpdateProfile()));
            },
          ),
          ListTile(
            trailing: Icon(Icons.book),
            title: Text("My Study Materials"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyStudyMaterials()));
            },
          ),
          ListTile(
            trailing: Icon(Icons.work),
            title: Text("My Jobs"),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyJobs()));
            },
          ),
          ListTile(
            trailing: Icon(Icons.question_answer),
            title: Text("My Questions"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyQuestions()));
            },
          ),
          ListTile(
            trailing: Icon(Icons.lightbulb),
            title: Text("My Quiz"),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyQuiz()));
            },
          ),
          ListTile(
            trailing: Icon(Icons.how_to_vote),
            title: Text("My Poll"),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyPoll()));
            },
          ),
          ListTile(
            trailing: Icon(Icons.videocam),
            title: Text("My Videos"),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyVideos()));
            },
          ),
          ListTile(
            trailing: Icon(Icons.contact_mail),
            title: Text("Contact Admin"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
