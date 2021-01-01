import 'package:agriglance/constants/study_material_card.dart';
import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';
import 'package:flutter/foundation.dart';

class MyStudyMaterials extends StatefulWidget {
  @override
  _MyStudyMaterialsState createState() => _MyStudyMaterialsState();
}

enum options { View, Download, Share }

class _MyStudyMaterialsState extends State<MyStudyMaterials> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final papersCollectionReference =
      FirebaseStorage.instance.ref().child("studyMaterials");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Study Materials"),
      ),
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
                .collection("study_materials")
                .where("postedBy", isEqualTo: auth.currentUser.uid.toString())
                .orderBy("isApprovedByAdmin", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot papers =
                            snapshot.data.documents[index];
                        return GestureDetector(
                          onTap: () async {
                            await _asyncSimpleDialog(
                                context, papers['pdfUrl'], papers['fileName']);
                          },
                          child: StudyMaterialCard(
                            title: papers['title'],
                            examName: papers['examName'],
                            description: papers['description'],
                            pdfUrl: papers['pdfUrl'],
                            postedByName: papers['postedByName'],
                            fileName: papers['fileName'],
                            approved: papers['isApprovedByAdmin'],
                            index: index,
                          ),
                        );
                      });
            },
          ),
        ),
      ),
    );
  }

  void _launchURL(url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

  void _shareInApps(String filename, String link) async {
    try {
      WcFlutterShare.share(
          sharePopupTitle: "Agriglance",
          subject: "Download",
          text:
              "Download pdf via this link: FileName: $filename $link \n Visit agriglance.com for more such materials",
          mimeType: 'text/plain');
    } catch (e) {
      print(e);
    }
  }

  void _shareInWeb(String filename, String url) {
    FlutterClipboard.copy(
            'Download pdf via this link: FileName: $filename $url \nGet more study materials and free mock test on agriglance.com ')
        .then((value) {
      Fluttertoast.showToast(
          msg: "Copied To Clipboard!",
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG);
    });
  }

  Future<options> _asyncSimpleDialog(
      BuildContext context, String url, String filename) async {
    return await showDialog<options>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Choose'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Fluttertoast.showToast(
                      msg: "PDF Download started...",
                      gravity: ToastGravity.BOTTOM);
                  _launchURL(url);
                },
                child: const Text('Download'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  if (kIsWeb)
                    _shareInWeb(filename, url);
                  else
                    _shareInApps(filename, url);
                },
                child: const Text('Share'),
              ),
            ],
          );
        });
  }
}
