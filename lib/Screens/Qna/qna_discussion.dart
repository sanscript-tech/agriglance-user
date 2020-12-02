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
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                ),
                Divider(
                  thickness: 4.0,
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
            right: 8.0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 8,
            left: 10.0),
        child: Row(
          children: [
            Container(
              width: deviceWidth / 1.5,
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50.0),
                      ),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    hintText: "Type in your comment",
                    fillColor: Colors.white70),
              ),
            ),
            SizedBox(
              width: 3.0,
            ),
            RawMaterialButton(
              onPressed: () => print("comment"),
              elevation: 2.0,
              fillColor: Colors.amber,
              child: Icon(
                Icons.send,
                size: 30.0,
              ),
              padding: EdgeInsets.all(15.0),
              shape: CircleBorder(),
            )
          ],
        ),
      ),
    );
  }
}
