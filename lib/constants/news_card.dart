import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:core';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsCard extends StatelessWidget {
  final bool approved;
  final String newsTitle;
  final String newsDescription;
  final String newsFile;
  final String newsDate;
  final String newsLink;
  final String newsPostedBy;

  NewsCard(
      {this.approved,
      this.newsTitle,
      this.newsDescription,
      this.newsDate,
      this.newsLink,
      this.newsFile,
      this.newsPostedBy});

  final TextStyle linkStyle = TextStyle(color: Colors.blue, fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(deviceWidth / 25),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Color(0xFF50E096), width: 2.0),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                ((approved == true)
                    ? "Approved by Admin"
                    : "Waiting for approval"),
                style: TextStyle(fontSize: 8.0),
              ),
              Text(
                "$newsTitle",
                style: GoogleFonts.oswald(
                    fontWeight: FontWeight.w500, fontSize: 20.0),
              ),
              Image.network(
                newsFile,
                height: deviceHeight / 2,
                width: deviceWidth,
              ),
              Text(
                'Description: $newsDescription',
              ),
              GestureDetector(
                onTap: () {
                  _launchURL(newsLink);
                },
                child: Container(
                  child: Text('Go To News', style: linkStyle),
                ),
              ),
              Text("${DateFormat('yMMMMd').format(DateTime.parse(newsDate))}"),
              (newsPostedBy != null && newsPostedBy != "")
                  ? Text("Posted By: $newsPostedBy")
                  : Text("Posted By: Anonymous"),
            ]),
      ),
    );
  }

  void _launchURL(url) async =>
      await canLaunch(url) ? await launch(url) : Fluttertoast.showToast(msg: "Could not launch $url");
}
