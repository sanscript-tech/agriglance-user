import 'package:agriglance/Screens/Polls/poll_results.dart';
import 'package:agriglance/Services/authenticate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  final List voters;
  final String pollID;

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
      this.index,
      this.voters,
      this.pollID});

  @override
  _PollVoteState createState() => _PollVoteState();
}

class _PollVoteState extends State<PollVote> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Q. ${widget.question}".toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0),
            ),
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
          (FirebaseAuth.instance.currentUser!=null)
              ? Center(
                  child: OutlineButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    borderSide:
                        BorderSide(color: Color(0xFF3EC3C1), width: 2.0),
                    onPressed: () async {
                      DocumentSnapshot doc = await FirebaseFirestore.instance
                          .collection("polls")
                          .doc(widget.pollID)
                          .get();

                      if (doc["voters"].contains(auth.currentUser.uid)) {
                        Widget okButton = FlatButton(
                          child: Text("OK"),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                        );
                        AlertDialog alert = AlertDialog(
                          title: Text("Error"),
                          content: Text("You have already voted"),
                          actions: [okButton],
                        );
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      } else {
                        List v = widget.voters;
                        v.add(auth.currentUser.uid);
                        await FirebaseFirestore.instance
                            .collection("polls")
                            .doc(widget.pollID)
                            .update({
                          'voters': v,
                        });
                        if (radioItem == 1) {
                          await FirebaseFirestore.instance
                              .collection("polls")
                              .doc(widget.pollID)
                              .update({
                            'totalVotesOnOption1':
                                widget.totalVotesOnOption1 + 1,
                          });
                        } else if (radioItem == 2) {
                          await FirebaseFirestore.instance
                              .collection("polls")
                              .doc(widget.pollID)
                              .update({
                            'totalVotesOnOption2':
                                widget.totalVotesOnOption2 + 1,
                          });
                        } else if (radioItem == 3) {
                          await FirebaseFirestore.instance
                              .collection("polls")
                              .doc(widget.pollID)
                              .update({
                            'totalVotesOnOption3':
                                widget.totalVotesOnOption3 + 1,
                          });
                        } else if (radioItem == 4) {
                          await FirebaseFirestore.instance
                              .collection("polls")
                              .doc(widget.pollID)
                              .update({
                            'totalVotesOnOption4':
                                widget.totalVotesOnOption4 + 1,
                          });
                        } else {
                          Widget okButton = FlatButton(
                            child: Text("Try again"),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          );
                          AlertDialog alert = AlertDialog(
                            title: Text("Sorry"),
                            content: Text("We ran into a problem"),
                            actions: [okButton],
                          );
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            },
                          );
                        }
                        Fluttertoast.showToast(
                            msg: "Voted!", gravity: ToastGravity.BOTTOM);
                      }
                    },
                    child: Text(
                      "Vote",
                      style: TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 18.0),
                    ),
                  ),
                )
              : Text(""),
          (FirebaseAuth.instance.currentUser!=null)
              ? Center(
                  child: OutlineButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    borderSide:
                        BorderSide(color: Color(0xFF3EC3C1), width: 2.0),
                    child: Text(
                      "Check Results",
                      style: TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 18.0),
                    ),
                    onPressed: () async {
                      DocumentSnapshot doc = await FirebaseFirestore.instance
                          .collection("polls")
                          .doc(widget.pollID)
                          .get();

                      if (doc["voters"].contains(auth.currentUser.uid)) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PollResults(
                                      option1: widget.option1,
                                      option2: widget.option2,
                                      option3: widget.option3,
                                      option4: widget.option4,
                                      totalVotesOnOption1:
                                          doc["totalVotesOnOption1"],
                                      totalVotesOnOption2:
                                          doc["totalVotesOnOption2"],
                                      totalVotesOnOption3:
                                          doc["totalVotesOnOption3"],
                                      totalVotesOnOption4:
                                          doc["totalVotesOnOption4"],
                                    )));
                      } else {
                        Widget okButton = FlatButton(
                          child: Text("Ok"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        );
                        AlertDialog alert = AlertDialog(
                          title: Text("Results Locked"),
                          content: Text("Vote first to unlock results"),
                          actions: [okButton],
                        );
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }
                    },
                  ),
                )
              : Center(
                child: RaisedButton(
                    color: Colors.amber,
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Authenticate()));
                    },
                    child: Text("Login to Vote"),
                  ),
              ),
        ],
      ),
    );
  }
}
