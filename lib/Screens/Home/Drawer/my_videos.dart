import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MyVideos extends StatefulWidget {
  @override
  _MyVideosState createState() => _MyVideosState();
}

class _MyVideosState extends State<MyVideos> {
  final TextStyle linkStyle = TextStyle(color: Colors.blue, fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text("My Videos"), centerTitle: true),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Videos")
            .where("postedBy",
                isEqualTo: FirebaseAuth.instance.currentUser.uid.toString())
            .orderBy('isApprovedByAdmin', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
              DocumentSnapshot videos = snapshot.data.docs[index];
              var url = videos['videoUrl'];

              return Center(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: width / 1,
                        child: (!kIsWeb)
                            ? YoutubePlayerBuilder(
                                player: YoutubePlayer(
                                  controller: YoutubePlayerController(
                                    initialVideoId:
                                        YoutubePlayer.convertUrlToId(url),
                                    flags: YoutubePlayerFlags(
                                        controlsVisibleAtStart: true,
                                        autoPlay: false,
                                        mute: false,
                                        disableDragSeek: false,
                                        loop: false,
                                        isLive: false,
                                        forceHD: false),
                                  ),
                                  showVideoProgressIndicator: true,
                                  liveUIColor: Colors.redAccent,
                                  bottomActions: [
                                    FullScreenButton(
                                      color: Colors.amber[700],
                                    ),
                                    CurrentPosition(),
                                    PlaybackSpeedButton(),
                                  ],
                                ),
                                builder: (context, player) {
                                  return Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            videos['lectureTitle'],
                                            style: GoogleFonts.notoSans(
                                                fontStyle: FontStyle.normal,
                                                fontSize: 20.0),
                                          ),
                                          Text(
                                            ((videos['isApprovedByAdmin'] == true)
                                                ? "Approved by Admin"
                                                : "Waiting for approval"),
                                            style: TextStyle(fontSize: 8.0),
                                          ),
                                        ],
                                      ),
                                      player,
                                    ],
                                  );
                                },
                              )
                            : Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        videos['lectureTitle'],
                                        style: GoogleFonts.notoSans(
                                            fontStyle: FontStyle.normal,
                                            fontSize: 20.0),
                                      ),
                                      Text(
                                        ((videos['isApprovedByAdmin'] == true)
                                            ? "Approved by Admin"
                                            : "Waiting for approval"),
                                        style: TextStyle(fontSize: 8.0),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _launchURL(url);
                                    },
                                    child: Text(
                                      "Link to the video",
                                      style: linkStyle,
                                    ),
                                  ),
                                ],
                              ))),
              );
            },
          );
        },
      ),
    );
  }

  void _launchURL(url) async => await canLaunch(url)
      ? await launch(url)
      : Fluttertoast.showToast(msg: 'Could not launch $url');
}
