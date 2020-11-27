import 'package:agriglance/Screens/add_jobs.dart';
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
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddJobs())),
        child: Icon(Icons.add),
      ),
    );
  }
}
