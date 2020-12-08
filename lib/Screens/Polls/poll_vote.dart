import 'package:firebase_auth/firebase_auth.dart';
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
  final FirebaseAuth auth = FirebaseAuth.instance;
  int radioItem;
  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Vote"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: deviceHeight / 20,
          ),
          Text(
            "Q. ${widget.question}",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
          ),
          RadioListTile(
            groupValue: radioItem,
            title: Text(widget.option1),
            value: 1,
            onChanged: (val) {
              setState(() {
                radioItem = val;
              });
            },
          ),
          RadioListTile(
            groupValue: radioItem,
            title: Text(widget.option2),
            value: 2,
            onChanged: (val) {
              setState(() {
                radioItem = val;
              });
            },
          ),
          RadioListTile(
            groupValue: radioItem,
            title: Text(widget.option3),
            value: 3,
            onChanged: (val) {
              setState(() {
                radioItem = val;
              });
            },
          ),
          RadioListTile(
            groupValue: radioItem,
            title: Text(widget.option4),
            value: 4,
            onChanged: (val) {
              setState(() {
                radioItem = val;
              });
            },
          ),
        ],
      ),
    );
  }
}
