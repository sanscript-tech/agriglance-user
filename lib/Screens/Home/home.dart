import 'package:agriglance/Screens/Home/Drawer/drawer.dart';
import 'package:agriglance/Screens/Jobs/jobs_home.dart';
import 'package:agriglance/Screens/Materials/materials_home.dart';
import 'package:agriglance/Screens/Qna/qna_home.dart';
import 'package:agriglance/Screens/Test/test_home.dart';
import 'package:agriglance/Services/authenticate.dart';
import 'package:agriglance/Services/authentication_service.dart';
import 'package:agriglance/Services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../route_names.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    if (FirebaseAuth.instance.currentUser != null) checkUserIsBanned();
    _tabController = new TabController(length: 4, vsync: this);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(child: Text("Agriglance")),
          actions: [
            (FirebaseAuth.instance.currentUser != null)
                ? Row(
                    children: [
                      Text(
                        "Logout",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: Icon(Icons.logout),
                        onPressed: () {
                          context.read<AuthenticationService>().signOut();
                          Fluttertoast.showToast(msg: "Logged Out");
                          setState(() {});
                          if (!kIsWeb)
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Authenticate()));
                        },
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: Icon(Icons.login),
                        onPressed: () {
                          Navigator.pushNamed(context,login);
                          setState(() {});
                        },
                      ),
                    ],
                  )
          ],
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.yellow,
            labelColor: Colors.yellow,
            unselectedLabelColor: Colors.white,
            onTap: (index) {},
            tabs: [
              Tab(
                text: "Test",
                icon: Icon(Icons.edit),
              ),
              Tab(
                text: "Materials",
                icon: Icon(Icons.my_library_books),
              ),
              Tab(
                text: "QNA",
                icon: Icon(Icons.question_answer),
              ),
              Tab(
                text: "Jobs",
                icon: Icon(Icons.work),
              )
            ],
          )),
      body: TabBarView(controller: _tabController, children: [
        TestHome(),
        MaterialsHome(),
        QnaHome(),
        JobsHome(),
      ]),
      drawer: DrawerWindow(),
    );
  }

  void checkUserIsBanned() {
    FirestoreService()
        .getUser(FirebaseAuth.instance.currentUser.uid)
        .then((user) {
      if (user.isBanned) {
        context.read<AuthenticationService>().signOut();
        Fluttertoast.showToast(
            msg: "User is banned by the Admin",
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG);
      }
    });
  }
}
