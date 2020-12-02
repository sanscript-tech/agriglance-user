import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StudyMaterialCard extends StatefulWidget {
  String type;
  String title;
  String description;
  String pdfUrl;
  String fileName;
  String postedByName;
  int index;

  StudyMaterialCard(
      {this.type,
      this.title,
      this.description,
      this.pdfUrl,
      this.fileName,
      this.postedByName,
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
              Text(
                "Type: " + widget.type,
                style: TextStyle(fontSize: 18.0),
              ),
              Text(
                "${widget.index + 1}. ${widget.title}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                "Description: " + widget.description,
                style: TextStyle(fontSize: 18.0),
              ),
              Text(
                "Posted By: " + widget.postedByName,
                style: TextStyle(fontSize: 18.0),
              ),
              Text(
                "Click to download and view the papers",
                style: TextStyle(fontSize: 10.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
