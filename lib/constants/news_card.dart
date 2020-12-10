import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:core';

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
    bool isImageAvailable = newsImage != null || newsImage != "" ? true : false;
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        side: BorderSide(),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(children: <Widget>[
        Text(
          "$newsTitle",
          style:
              GoogleFonts.oswald(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        Visibility(visible: isImageAvailable, child: Image.network(newsImage)),
        Text(
          '$newsDescription',
          style: GoogleFonts.dynalight(
              fontWeight: FontWeight.normal, fontSize: 25.0),
        ),
        Row(
          children: <Widget>[
            Text('$newsDate'),
            Text('    '),
            Text('$newsPostedBy'),
          ],
        ),
      ]),
    );
  }
}
