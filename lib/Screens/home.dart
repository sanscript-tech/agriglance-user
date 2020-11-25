import 'package:agriglance/Screens/materials_home.dart';
import 'package:agriglance/Screens/profile.dart';
import 'package:agriglance/Screens/test_home.dart';
import 'package:agriglance/Services/authentication_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    _tabController = new TabController(length: 4, vsync: this);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Agriglance")),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                context.read<AuthenticationService>().signOut();
              },
            ),
          ],
          bottom: TabBar(
            controller: _tabController,
            onTap: (index) {},
            tabs: [
              Tab(
                text: "Test",
              ),
              Tab(
                text: "Material",
              ),
              Tab(text: "QNA"),
              Tab(
                text: "Jobs",
              )
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              ListTile(
                trailing: Icon(Icons.account_circle),
                title: Text("Profile"),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Profile()));
                },
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            TestHome(),
            MaterialsHome(),
            Text("This is notification Tab View"),
            Text("This is notification Tab View"),
          ],
        ));
  }
}
