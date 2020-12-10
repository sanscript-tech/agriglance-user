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
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Color(0xFF3E83C3), width: 2.0),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${widget.index + 1}. ${widget.title}".toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0),
              ),
              Padding(
                padding: EdgeInsets.only(left: deviceWidth / 20),
                child: Text(
                  "Type: " + widget.type,
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: deviceWidth / 20),
                child: Text(
                  "Description: " + widget.description,
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: deviceWidth / 20),
                child: Text(
                  (widget.postedByName != null && widget.postedByName != "")
                      ? "Posted By: " + widget.postedByName
                      : "Posted By: FAnonymous",
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: deviceWidth / 20),
                    child: Text(
                      "Click to download and view the papers",
                      style: TextStyle(fontSize: 8.0),
                    ),
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
