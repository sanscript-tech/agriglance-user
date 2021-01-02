import 'package:agriglance/Screens/Home/Drawer/drawer.dart';
import 'package:agriglance/Screens/Jobs/jobs_home.dart';
import 'package:agriglance/Screens/Materials/materials_home.dart';
import 'package:agriglance/Screens/Qna/qna_home.dart';
import 'package:agriglance/Screens/Test/test_home.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  static const String route = "/";
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWindow(),
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        centerTitle: true,
        title: Text(
          "Agriglance"
        )
      ),

     
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
            RaisedButton(
              child: Text("Tests"),
              onPressed: () {
                Navigator.of(context).pushNamed(TestHome.route);
              },
            ),
            RaisedButton(
              child: Text("Materials"),
              onPressed: () {
                Navigator.of(context).pushNamed(MaterialsHome.route);
              },
            ),
            RaisedButton(
              child: Text("QnA"),
              onPressed: () {
                Navigator.of(context).pushNamed(QnaHome.route);
              },
            ),
            RaisedButton(
              child: Text("Jobs"),
              onPressed: () {
                Navigator.of(context).pushNamed(JobsHome.route);
              },
            ),
          ],
        ),
      ),
    );
  }
}
