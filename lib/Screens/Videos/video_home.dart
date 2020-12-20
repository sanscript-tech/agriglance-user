import 'package:agriglance/Screens/Videos/submit_video.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/foundation.dart';

class VideoHome extends StatefulWidget {
  @override
  _VideoHomeState createState() => _VideoHomeState();
}

class _VideoHomeState extends State<VideoHome> {
  final TextStyle linkStyle = TextStyle(color: Colors.blue, fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: (FirebaseAuth.instance.currentUser != null)
          ? FloatingActionButton(
              child: Icon(
                Icons.add,
                size: 30.0,
              ),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SubmitVideo())),
            )
          : null,
      appBar: AppBar(title: Text("Learning Videos"), centerTitle: true),
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
          ], color: Colors.amber[100], border: Border.all(color: Colors.white)),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Videos")
                .orderBy('isApprovedByAdmin', descending: true)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                  if (videos['isApprovedByAdmin']) {
                    var url = videos['videoUrl'];

                    return Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Card(
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            side: BorderSide(width: 2.0)),
                        child: Center(
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: width / 1,
                                  child: (!kIsWeb)
                                      ? YoutubePlayerBuilder(
                                          player: YoutubePlayer(
                                            controller: YoutubePlayerController(
                                              initialVideoId:
                                                  YoutubePlayer.convertUrlToId(
                                                      url),
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
                                                Text(
                                                  videos['lectureTitle'],
                                                  style: GoogleFonts.notoSans(
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontSize: 20.0),
                                                ),
                                                player,
                                              ],
                                            );
                                          },
                                        )
                                      : Column(
                                          children: [
                                            Text(
                                              videos['lectureTitle'],
                                              style: GoogleFonts.notoSans(
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 20.0),
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
                        ),
                      ),
                    );
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

  void _launchURL(url) async => await canLaunch(url)
      ? await launch(url)
      : Fluttertoast.showToast(msg: 'Could not launch $url');
}
