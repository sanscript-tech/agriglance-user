import 'package:flutter/material.dart';

class PollResults extends StatefulWidget {
  @override
  _PollResultsState createState() => _PollResultsState();
}

class _PollResultsState extends State<PollResults> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Results"),
        centerTitle: true,
      ),
    );
  }
}
