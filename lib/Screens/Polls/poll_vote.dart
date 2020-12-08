import 'package:flutter/material.dart';

class PollVote extends StatefulWidget {
  final String question;
  final String option1;
  final String option2;
  final String option3;
  final String option4;
  final int totalVotesOnOption1;
  final int totalVotesOnOption2;
  final int totalVotesOnOption3;
  final int totalVotesOnOption4;
  final int index;
  PollVote(
      {this.option1,
      this.option2,
      this.option3,
      this.option4,
      this.question,
      this.totalVotesOnOption1,
      this.totalVotesOnOption2,
      this.totalVotesOnOption3,
      this.totalVotesOnOption4,
      this.index});
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
      body: Column(
        children: [],
      ),
    );
  }
}
