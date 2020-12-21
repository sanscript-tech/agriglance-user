import 'package:agriglance/Screens/Materials/materials_home.dart';
import 'package:agriglance/Screens/News/create_news.dart';
import 'package:agriglance/services/admob_service.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants/news_card.dart';

class NewsHome extends StatefulWidget {
  @override
  _NewsHomeState createState() => _NewsHomeState();
}

class _NewsHomeState extends State<NewsHome> {
  String _newsPostedBy = "";
  final ams = AdMobService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: (FirebaseAuth.instance.currentUser != null)
          ? FloatingActionButton(
              child: Icon(
                Icons.add,
                size: 30.0,
              ),
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
                print("No Of Clicks $noOfClicks");
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateNews()));
              },
            )
          : null,
      appBar: AppBar(title: Text("News"), centerTitle: true),
      body: Center(
        child: Container(
          width: 700.0,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 25.0, // soften the shadow
              spreadRadius: 5.0, //extend the shadow
              offset: Offset(
                15.0,
                15.0,
              ),
            )
          ], color: Colors.yellow[50], border: Border.all(color: Colors.white)),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("News")
                .orderBy("isApprovedByAdmin", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.amber,
                  ),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot news = snapshot.data.docs[index];
                  _newsPostedBy =
                      news['uname'] != "" ? news['uname'] : "Anonymous";

                  if (news['isApprovedByAdmin']) {
                    return NewsCard(
                        approved: news['isApprovedByAdmin'],
                        newsTitle: news['title'],
                        newsDescription: news['description'],
                        newsFile: news['fileUrl'],
                        newsLink: news['newsLink'],
                        newsDate: news['postedAt'],
                        newsPostedBy: _newsPostedBy);
                  }
                  return null;
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
