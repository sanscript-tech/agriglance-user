import 'package:agriglance/Screens/Home/Drawer/contactAdmin.dart';
import 'package:agriglance/Screens/Home/Drawer/my_documents.dart';
import 'package:agriglance/Screens/Home/Drawer/my_images.dart';
import 'package:agriglance/Screens/Home/Drawer/my_jobs.dart';
import 'package:agriglance/Screens/Home/Drawer/my_points.dart';
import 'package:agriglance/Screens/Home/Drawer/my_poll.dart';
import 'package:agriglance/Screens/Home/Drawer/my_question_papers.dart';
import 'package:agriglance/Screens/Home/Drawer/my_questions.dart';
import 'package:agriglance/Screens/Home/Drawer/my_quiz.dart';
import 'package:agriglance/Screens/Home/Drawer/my_study_materials.dart';
import 'package:agriglance/Screens/Home/Drawer/my_thesis.dart';
import 'package:agriglance/Screens/Home/Drawer/my_videos.dart';
import 'package:agriglance/Services/authenticate.dart';
import 'package:agriglance/Services/firestore_service.dart';
import 'package:agriglance/route_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Profile/profile.dart';
import '../Profile/update_profile.dart';
import 'my_news_and_currentAffairs.dart';

class DrawerWindow extends StatefulWidget {
  @override
  _DrawerWindowState createState() => _DrawerWindowState();
}

class _DrawerWindowState extends State<DrawerWindow> {
  FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      return FutureBuilder(
          future:
              _firestoreService.getUser(FirebaseAuth.instance.currentUser.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return drawerWidget(context, snapshot);
            } else {
              return Container(
                  child: Center(child: CircularProgressIndicator()));
            }
          });
    } else {
      return Drawer(
        elevation: 10.0,
        child: Center(
          child: RaisedButton(
            color: Colors.amber,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Authenticate()));
            },
            child: Text("Login to Access"),
          ),
        ),
      );
    }
  }

  Widget drawerWidget(BuildContext context, AsyncSnapshot snapshot) {
    final userData = snapshot.data;
    return Drawer(
      elevation: 10.0,
      child: ListView(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, profileRoute);
            },
            child: UserAccountsDrawerHeader(
              accountName: Text(
                userData.fullName == "" ? "Anonymous" : userData.fullName,
                style: TextStyle(fontSize: 20.0),
              ),
              accountEmail: Text(userData.email),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text(
                  userData.fullName == "" ? "A" : userData.fullName[0],
                  style: TextStyle(fontSize: 40.0, color: Colors.black),
                ),
              ),
            ),
          ),
          ListTile(
            trailing: Icon(Icons.edit),
            title: Text("Update Profile"),
            onTap: () {
              Navigator.pushNamed(context, updateProfileRoute);
            },
          ),
          ListTile(
            trailing: Icon(Icons.monetization_on),
            title: Text("My Points"),
            onTap: () {
              Navigator.pushNamed(context, myPointsRoute);
            },
          ),
          ListTile(
            trailing: Icon(Icons.book),
            title: Text("My Study Materials"),
            onTap: () {
              Navigator.pushNamed(context, myStudyMaterialsRoute);
            },
          ),
          ListTile(
            trailing: FaIcon(FontAwesomeIcons.question),
            title: Text("My Question Papers"),
            onTap: () {
              Navigator.pushNamed(context, myQuestionPaperRoute);
            },
          ),
          ListTile(
            trailing: FaIcon(FontAwesomeIcons.solidFile),
            title: Text("My Documents"),
            onTap: () {
              Navigator.pushNamed(context, myDocumentRoute);
            },
          ),
          ListTile(
            trailing: FaIcon(FontAwesomeIcons.solidNewspaper),
            title: Text("My Thesis"),
            onTap: () {
              Navigator.pushNamed(context, myThesisRoute);
            },
          ),
          ListTile(
            trailing: Icon(Icons.work),
            title: Text("My Jobs"),
            onTap: () {
              Navigator.pushNamed(context, myJobsRoute);
            },
          ),
          ListTile(
            trailing: Icon(Icons.question_answer),
            title: Text("My Questions"),
            onTap: () {
              Navigator.pushNamed(context, myQuestionsRoute);
            },
          ),
          ListTile(
            trailing: Icon(Icons.trending_up),
            title: Text("My News and CurrentAffairs"),
            onTap: () {
              Navigator.pushNamed(context, myNewsRoute);
            },
          ),
          ListTile(
            trailing: Icon(Icons.how_to_vote),
            title: Text("My Poll"),
            onTap: () {
              Navigator.pushNamed(context, myPollRoute);
            },
          ),
          ListTile(
            trailing: Icon(Icons.lightbulb),
            title: Text("My Quiz"),
            onTap: () {
              Navigator.pushNamed(context, myQuizRoute);
            },
          ),
          ListTile(
            trailing: Icon(Icons.videocam),
            title: Text("My Videos"),
            onTap: () {
              Navigator.pushNamed(context, myVideoRoute);
            },
          ),
          ListTile(
            trailing: Icon(Icons.image),
            title: Text("My Images"),
            onTap: () {
              Navigator.pushNamed(context, myImageRoute);
            },
          ),
          ListTile(
            trailing: Icon(Icons.contact_mail),
            title: Text("Contact Admin"),
            onTap: () {
              Navigator.pushNamed(context, contactAdminRoute);
            },
          ),
        ],
      ),
    );
  }
}
