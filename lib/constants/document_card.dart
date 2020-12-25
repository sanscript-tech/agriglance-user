import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DocumentCard extends StatefulWidget {
  String type;
  String title;
  String description;
  String keywords;
  String author;
  String pdfUrl;
  String fileName;
  String postedByName;
  bool approved;
  int index;

  DocumentCard(
      {this.type,
      this.title,
      this.description,
      this.pdfUrl,
      this.keywords,
      this.author,
      this.fileName,
      this.postedByName,
      this.approved,
      this.index});

  @override
  _DocumentCardState createState() => _DocumentCardState();
}

class _DocumentCardState extends State<DocumentCard> {
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
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
                "${widget.type} ",
                style: TextStyle(fontSize: 12.0),
              ),
              Text(
                "Title : ${widget.title} ".toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0),
              ),
              Text(
                "Author: ${widget.author} ",
                style: TextStyle(fontSize: 12.0),
              ),
              Padding(
                padding: EdgeInsets.only(left: deviceWidth / 20),
                child: Text(
                  "${widget.description}",
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: deviceWidth / 20),
                child: Text(
                  "Keywords: ${widget.keywords}",
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: deviceWidth / 20),
                child: Text(
                  (widget.postedByName != null && widget.postedByName != "")
                      ? "Posted By: " + widget.postedByName
                      : "Posted By: Anonymous",
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: deviceWidth / 20),
                    child: Text(
                      "Click to view Options",
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
