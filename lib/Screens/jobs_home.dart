import 'package:flutter/material.dart';

class JobsHome extends StatefulWidget {
  @override
  _JobsHomeState createState() => _JobsHomeState();
}

class _JobsHomeState extends State<JobsHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => print("Tapped"),
        child: Icon(Icons.add),
      ),
    );
  }
}
