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
    return Container();
  }
}
