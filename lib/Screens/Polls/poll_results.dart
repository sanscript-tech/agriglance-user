import 'package:flutter/material.dart';

class PollResults extends StatefulWidget {
  final String option1;
  final String option2;
  final String option3;
  final String option4;
  final int totalVotesOnOption1;
  final int totalVotesOnOption2;
  final int totalVotesOnOption3;
  final int totalVotesOnOption4;
  PollResults(
      {this.option1,
      this.option2,
      this.option3,
      this.option4,
      this.totalVotesOnOption1,
      this.totalVotesOnOption2,
      this.totalVotesOnOption3,
      this.totalVotesOnOption4});
  @override
  _PollResultsState createState() => _PollResultsState();
}

class _PollResultsState extends State<PollResults> {
  @override
  Widget build(BuildContext context) {
    int totalVotes = widget.totalVotesOnOption1 +
        widget.totalVotesOnOption2 +
        widget.totalVotesOnOption3 +
        widget.totalVotesOnOption4;
    return Scaffold(
      appBar: AppBar(
        title: Text("Results"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "${widget.option1}: ${(widget.totalVotesOnOption1 / totalVotes) * 100}%",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
          ),
          Text(
            "${widget.option2}: ${(widget.totalVotesOnOption2 / totalVotes) * 100}%",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
          ),
          Text(
            "${widget.option3}: ${(widget.totalVotesOnOption3 / totalVotes) * 100}%",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
          ),
          Text(
            "${widget.option4}: ${(widget.totalVotesOnOption4 / totalVotes) * 100}%",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
          )
        ],
      ),
    );
  }
}
