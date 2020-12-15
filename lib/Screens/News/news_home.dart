import 'package:agriglance/Screens/News/create_news.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants/news_card.dart';

class NewsHome extends StatefulWidget {
  @override
  _NewsHomeState createState() => _NewsHomeState();
}

class _NewsHomeState extends State<NewsHome> {
  String _newsPostedBy = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 30.0,
        ),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => CreateNews())),
      ),
      appBar: AppBar(title: Text("News"), centerTitle: true),
      body: StreamBuilder(
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
              _newsPostedBy = news['uname'] != "" ? news['uname'] : "Anonymous";

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
    );
  }
}
