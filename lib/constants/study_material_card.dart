import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StudyMaterialCard extends StatefulWidget {
  String type;
  String title;
  String subject;
  String description;
  String pdfUrl;
  String fileName;
  String postedByName;
  bool approved;
  int index;

  StudyMaterialCard(
      {this.type,
      this.title,
      this.subject,
      this.description,
      this.pdfUrl,
      this.fileName,
      this.postedByName,
      this.approved,
      this.index});

  @override
  _StudyMaterialCardState createState() => _StudyMaterialCardState();
}

class _StudyMaterialCardState extends State<StudyMaterialCard> {
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Card(
        color: Colors.yellow[200],
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Type: " + widget.type,
                    style: TextStyle(fontSize: 10.0),
                  ),
                  Text(
                    "Subject: " +
                        (widget.subject == null ? "None" : widget.subject),
                    style: TextStyle(fontSize: 10.0),
                  ),
                ],
              ),
              Text(
                "${widget.index + 1}. ${widget.title}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
              ),
              Text(
                "Description: " + widget.description,
                style: TextStyle(fontSize: 10.0),
              ),
              Text(
                "Posted By: " + widget.postedByName,
                style: TextStyle(fontSize: 10.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Click to download and view the papers",
                    style: TextStyle(fontSize: 7.0),
                  ),
                  Text(
                    ((widget.approved == true)
                        ? "Approved by Admin"
                        : "Waiting for approval"),
                    style: TextStyle(fontSize: 8.0),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
