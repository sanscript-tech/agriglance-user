import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:core';
import 'package:intl/intl.dart';

class NewsCard extends StatelessWidget {
  final String newsTitle;
  final String newsDescription;
  final String newsImage;
  final String newsFile;
  final String newsDate;
  final String newsPostedBy;

  NewsCard(
      {this.newsTitle,
      this.newsDescription,
      this.newsDate,
      this.newsFile,
      this.newsImage,
      this.newsPostedBy});

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    bool isImageAvailable = newsImage != null || newsImage != "" ? true : false;
    return Container(
      padding: EdgeInsets.all(deviceWidth / 15),
      child: Card(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Color(0xFF50E096), width: 2.0),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "$newsTitle",
                style: GoogleFonts.oswald(
                    fontWeight: FontWeight.w500, fontSize: 20.0),
              ),
              Visibility(
                  visible: isImageAvailable,
                  child: Image.network(
                    newsImage,
                    height: deviceHeight / 4,
                  )),
              Text(
                'Description: $newsDescription',
              ),
              Text("${DateFormat('yMMMMd').format(DateTime.parse(newsDate))}"),
              (newsPostedBy != null && newsPostedBy != "")
                  ? Text("Posted By: $newsPostedBy")
                  : Text("Posted By: Anonymous"),
              SizedBox(
                height: deviceHeight / 40,
              )
            ]),
      ),
    );
  }
}
