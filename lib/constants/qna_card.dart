import 'package:agriglance/Screens/Materials/materials_home.dart';
import 'package:agriglance/Screens/Qna/qna_discussion.dart';
import 'package:agriglance/services/admob_service.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class QnaCard extends StatefulWidget {
  String category;
  String question;
  String description;
  String postedBy;
  int index;
  String qid;
  QnaCard(
      {this.category,
      this.description,
      this.question,
      this.postedBy,
      this.index,
      this.qid});
  @override
  _QnaCardState createState() => _QnaCardState();
}

class _QnaCardState extends State<QnaCard> {
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    final ams = AdMobService();
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Card(
        color: Colors.yellow[50],
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.orange, width: 3.0),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${widget.question}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              (widget.postedBy != null && widget.postedBy != "")
                  ? Text(
                      "Posted By: " + widget.postedBy,
                      style: TextStyle(fontSize: 16.0),
                    )
                  : Text(
                      "Posted By : Anonymous",
                      style: TextStyle(fontSize: 16.0),
                    ),
              Center(
                  child: RaisedButton(
                onPressed: () {
                  if (!kIsWeb && noOfClicks % 5 == 0) {
                    InterstitialAd newAd = ams.getInterstitialAd();
                    newAd.load();
                    newAd.show(
                      anchorType: AnchorType.bottom,
                      anchorOffset: 0.0,
                      horizontalCenterOffset: 0.0,
                    );
                    noOfClicks++;
                  }
                  noOfClicks++;
                  print("No of clicks $noOfClicks");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Discussion(
                                question: widget.question,
                                postedBy: widget.postedBy,
                                description: widget.description,
                                qid: widget.qid,
                              )));
                },
                color: Colors.orangeAccent.shade100,
                child: Text("Reply"),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
