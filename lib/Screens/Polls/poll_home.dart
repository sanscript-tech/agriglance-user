import 'package:agriglance/Screens/Polls/add_polls.dart';
import 'package:flutter/material.dart';

class PollHome extends StatefulWidget {
  @override
  _PollHomeState createState() => _PollHomeState();
}

class _PollHomeState extends State<PollHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Polls"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddPoll())),
        child: Icon(Icons.add),
      ),
    );
  }
}
