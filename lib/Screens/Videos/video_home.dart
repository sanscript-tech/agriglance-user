import 'package:agriglance/Screens/Videos/submit_video.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class VideoHome extends StatefulWidget {
  @override
  _VideoHomeState createState() => _VideoHomeState();
}

class _VideoHomeState extends State<VideoHome> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Column(
          children: <Widget>[
            Icon(
              Icons.add,
              size: 40.0,
            ),
            Text(
              "Add video",
              style: TextStyle(fontSize: 10.0),
            ),
          ],
        ),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => SubmitVideo())),
      ),
      appBar: AppBar(title: Text("Learning videos"), centerTitle: true),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Videos").snapshots(),
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
              if (videos['isApprovedByAdmin']) {
                var url = videos['videoUrl'];

                YoutubePlayerController _controller = YoutubePlayerController(
                  initialVideoId: YoutubePlayer.convertUrlToId(url),
                  flags: YoutubePlayerFlags(
                      controlsVisibleAtStart: true,
                      autoPlay: false,
                      mute: false,
                      disableDragSeek: false,
                      loop: false,
                      isLive: false,
                      forceHD: false),
                );

                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: width / 1,
                      child: YoutubePlayerBuilder(
                        player: YoutubePlayer(
                          controller: _controller,
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
                                style: GoogleFonts.ranchers(
                                    fontStyle: FontStyle.normal,
                                    fontSize: 20.0),
                              ),
                              player,
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                );
              }
              return null;
            },
          );
        },
      ),
    );
  }
}
