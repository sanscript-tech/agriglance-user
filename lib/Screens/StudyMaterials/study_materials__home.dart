import 'dart:async';
import 'dart:core';

import 'package:agriglance/Screens/StudyMaterials/add_study_material.dart';
import 'package:agriglance/constants/study_material_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class StudyMaterialsHome extends StatefulWidget {
  @override
  _StudyMaterialsHomeState createState() => _StudyMaterialsHomeState();
}

enum options { View, Download, Share }

class _StudyMaterialsHomeState extends State<StudyMaterialsHome> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final papersCollectionReference =
      FirebaseStorage.instance.ref().child("studyMaterials");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Study Materials"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddStudyMaterial(
                      uid: auth.currentUser.uid,
                      uName: auth.currentUser.displayName)));
        },
        child: Icon(Icons.add),
      ),
      body: Container(
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
                      DocumentSnapshot papers = snapshot.data.documents[index];
                      if (papers['isApprovedByAdmin']) {
                        return GestureDetector(
                          onTap: () async {
                            await _asyncSimpleDialog(
                                context, papers['pdfUrl'], papers['fileName']);
                          },
                          child: StudyMaterialCard(
                            type: papers['type'],
                            title: papers['title'],
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
    );
  }

  void _share(String link) async {
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
      await canLaunch(url) ? await launch(url) : Fluttertoast.showToast(msg: "Could not launch $url");

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
                  // download(url, filename);
                  _launchURL(url);
                },
                child: const Text('Download'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  _share(url);
                },
                child: const Text('Share'),
              ),
            ],
          );
        });
  }
}
