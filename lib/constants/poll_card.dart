import 'package:flutter/material.dart';

class PollCard extends StatefulWidget {
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
  final String postedByName;
  PollCard(
      {this.option1,
      this.option2,
      this.option3,
      this.option4,
      this.question,
      this.totalVotesOnOption1,
      this.totalVotesOnOption2,
      this.totalVotesOnOption3,
      this.totalVotesOnOption4,
      this.index,
      this.postedByName});

  @override
  _PollCardState createState() => _PollCardState();
}

class _PollCardState extends State<PollCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: GestureDetector(
          onTap: () => print("Tapped"),
          child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.index + 1}. ${widget.question}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  (widget.postedByName != null)
                      ? Text(
                          "Posted By: " + widget.postedByName,
                          style: TextStyle(fontSize: 16.0),
                        )
                      : Text(
                          "Posted By : Anonymous",
                          style: TextStyle(fontSize: 16.0),
                        ),
                  Text("Total Votes: ${widget.totalVotesOnOption1+widget.totalVotesOnOption2+widget.totalVotesOnOption3+widget.totalVotesOnOption4}")
                ],
              ),
            )),
    ));
  }
}
