import 'dart:async';
import 'dart:core';

import 'package:agriglance/Models/usermodel.dart';
import 'package:agriglance/Screens/Materials/materials_home.dart';
import 'package:agriglance/Screens/StudyMaterials/add_study_material.dart';
import 'package:agriglance/Services/firestore_service.dart';
import 'package:agriglance/constants/study_material_card.dart';
import 'package:agriglance/services/admob_service.dart';
import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class StudyMaterialsHome extends StatefulWidget {
  @override
  _StudyMaterialsHomeState createState() => _StudyMaterialsHomeState();
}

enum options { Download, Share }

class _StudyMaterialsHomeState extends State<StudyMaterialsHome> {
  final ams = (!kIsWeb) ? AdMobService() : null;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final papersCollectionReference =
  FirebaseStorage.instance.ref().child("studyMaterials");
  String uName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Study Materials"),
      ),
      floatingActionButton: (FirebaseAuth.instance.currentUser != null)
          ? FloatingActionButton(
        onPressed: () async {
          UserModel updateUser = await FirestoreService()
              .getUser(FirebaseAuth.instance.currentUser.uid);
          setState(() {
            uName = updateUser.fullName;
          });
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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AddStudyMaterial()));
        },
        child: Icon(Icons.add),
      )
          : null,
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
                  if (papers['isApprovedByAdmin']) {
                    return GestureDetector(
                      onTap: () async {
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
                        await _asyncSimpleDialog(context,
                            papers['pdfUrl'], papers['fileName']);
                      },
                      child: StudyMaterialCard(
                        subject: papers['subject'],
                        title: papers['title'],
                        examName:papers['examName'],
                        description: papers['description'],
                        pdfUrl: papers['pdfUrl'],
                        postedByName: papers['postedByName'],
                        fileName: papers['fileName'],
                        approved: papers['isApprovedByAdmin'],
                        index: index,
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

  void _shareInApps(String link) async {
    try {
      WcFlutterShare.share(
          sharePopupTitle: "Agriglance",
          subject: "Download",
          text:
          "Download pdf via this link: $link \n Visit agriglance.com for more such materials",
          mimeType: 'text/plain');
    } catch (e) {
      print(e);
    }
  }

  void _launchURL(url) async =>
      await canLaunch(url)
          ? await launch(url)
          : Fluttertoast.showToast(msg: "Could not launch $url");

  Future<options> _asyncSimpleDialog(BuildContext context, String url,
      String filename) async {
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
                  // download(url, filename);
                  _launchURL(url);
                },
                child: const Text('Download'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  if (!kIsWeb)
                    _shareInApps(url);
                  else
                    _shareInWeb(url);
                },
                child: const Text('Share'),
              ),
            ],
          );
        });
  }

  void _shareInWeb(String url) {
    FlutterClipboard.copy(
        'Download pdf via this link: $url \nGet more study materials and free mock test on agriglance.com ')
        .then((value) {
      Fluttertoast.showToast(
          msg: "Copied To Clipboard!",
          gravity: ToastGravity.BOTTOM, toastLength: Toast.LENGTH_LONG);
    });
  }
}
