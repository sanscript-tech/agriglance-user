import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResearchPaperCard extends StatefulWidget {

  String title;
  String description;
  String pdfUrl;
  String postedByName;
  int index;

  ResearchPaperCard({this.title, this.description, this.pdfUrl,
      this.postedByName, this.index});

  @override
  _ResearchPaperCardState createState() => _ResearchPaperCardState();
}

class _ResearchPaperCardState extends State<ResearchPaperCard> {
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      height: deviceHeight / 7,
      padding: EdgeInsets.all(10.0),
      child: Card(
        color: Colors.yellow[200],
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
