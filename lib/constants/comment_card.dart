import 'package:flutter/material.dart';

class CommentCard extends StatefulWidget {
  String comment;
  String postedBy;
  CommentCard({this.comment, this.postedBy});
  @override
  _CommentCardState createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(10.0),
      child: Card(
        elevation: 0.0,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.comment,
                style: TextStyle(fontSize: 17.0),
              ),
              (widget.postedBy != null && widget.postedBy != "")
                  ? Text("- ${widget.postedBy}")
                  : Text(
                      "- Anonymous",
                      style: TextStyle(
                          fontSize: 10.0, fontWeight: FontWeight.bold),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
