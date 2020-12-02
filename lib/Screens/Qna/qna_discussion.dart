import 'package:flutter/material.dart';

class Discussion extends StatefulWidget {
  String question;
  String description;
  String postedBy;
  Discussion({this.description, this.postedBy, this.question});
  @override
  _DiscussionState createState() => _DiscussionState();
}

class _DiscussionState extends State<Discussion> {
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("QNA"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.question,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                ),
                Text(
                  widget.description,
                  style: TextStyle(fontSize: 18.0),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
