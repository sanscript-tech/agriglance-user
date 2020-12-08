import 'dart:core';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ApplicantCard extends StatefulWidget {
  String appliedBy;
  String cvFileName;
  String cvUrl;
  String appliedByName;
  int index;

  ApplicantCard(
      {this.appliedBy,
      this.cvFileName,
      this.cvUrl,
      this.appliedByName,
      this.index});

  @override
  _ApplicantCardState createState() => _ApplicantCardState();
}

class _ApplicantCardState extends State<ApplicantCard> {
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(10.0),
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
              widget.appliedByName != null
                  ? Text(
                      "${widget.index + 1}. Applied by ${widget.appliedByName}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )
                  : Text(
                      "Applied by Anonymous",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
              Text(
                "Click to download CV",
                style: TextStyle(fontSize: 10.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
