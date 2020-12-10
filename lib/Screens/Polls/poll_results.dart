import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

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
      body: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height / 30),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "${widget.option1}: ",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25.0),
                ),
                CircularPercentIndicator(
                  animationDuration: 200,
                  animateFromLastPercent: true,
                  arcType: ArcType.FULL,
                  arcBackgroundColor: Colors.black12,
                  backgroundColor: Colors.white,
                  percent: widget.totalVotesOnOption1 / totalVotes,
                  animation: true,
                  lineWidth: 12.0,
                  center: Text(
                      "${((widget.totalVotesOnOption1 / totalVotes) * 100).toStringAsPrecision(3)}%"),
                  circularStrokeCap: CircularStrokeCap.butt,
                  radius: 100,
                )
              ],
            ),
            Row(
              children: [
                Text(
                  "${widget.option2}: ",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25.0),
                ),
                CircularPercentIndicator(
                  animationDuration: 200,
                  animateFromLastPercent: true,
                  arcType: ArcType.FULL,
                  arcBackgroundColor: Colors.black12,
                  backgroundColor: Colors.white,
                  percent: widget.totalVotesOnOption2 / totalVotes,
                  animation: true,
                  lineWidth: 12.0,
                  circularStrokeCap: CircularStrokeCap.butt,
                  radius: 100,
                  center: Text(
                      "${((widget.totalVotesOnOption2 / totalVotes) * 100).toStringAsPrecision(3)}%"),
                )
              ],
            ),
            Row(
              children: [
                Text(
                  "${widget.option3}: ",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25.0),
                ),
                CircularPercentIndicator(
                  animationDuration: 200,
                  animateFromLastPercent: true,
                  arcType: ArcType.FULL,
                  arcBackgroundColor: Colors.black12,
                  backgroundColor: Colors.white,
                  percent: widget.totalVotesOnOption3 / totalVotes,
                  animation: true,
                  lineWidth: 12.0,
                  circularStrokeCap: CircularStrokeCap.butt,
                  radius: 100,
                  center: Text(
                      "${((widget.totalVotesOnOption3 / totalVotes) * 100).toStringAsPrecision(3)}%"),
                )
              ],
            ),
            Row(
              children: [
                Text(
                  "${widget.option4}: ",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25.0),
                ),
                CircularPercentIndicator(
                  animationDuration: 200,
                  animateFromLastPercent: true,
                  arcType: ArcType.FULL,
                  arcBackgroundColor: Colors.black12,
                  backgroundColor: Colors.white,
                  percent: widget.totalVotesOnOption4 / totalVotes,
                  animation: true,
                  lineWidth: 12.0,
                  circularStrokeCap: CircularStrokeCap.butt,
                  radius: 100,
                  center: Text(
                      "${((widget.totalVotesOnOption4 / totalVotes) * 100).toStringAsPrecision(3)}%"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
