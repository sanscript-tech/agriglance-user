import 'package:flutter/material.dart';

class PollVote extends StatefulWidget {
  @override
  _PollVoteState createState() => _PollVoteState();
}

class _PollVoteState extends State<PollVote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vote"),
        centerTitle: true,
      ),
    );
  }
}
