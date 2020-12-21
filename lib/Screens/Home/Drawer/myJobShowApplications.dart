import 'package:agriglance/constants/applicant_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class MyJobShowApplications extends StatefulWidget {
  String jobId;

  MyJobShowApplications({this.jobId});

  @override
  _MyJobShowApplicationsState createState() => _MyJobShowApplicationsState();
}

class _MyJobShowApplicationsState extends State<MyJobShowApplications> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Applications"),
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
                .collection("jobs")
                .doc(widget.jobId)
                .collection("applicants")
                .snapshots(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot applicant =
                            snapshot.data.documents[index];
                        return GestureDetector(
                          onTap: () {
                            Fluttertoast.showToast(
                                msg: "PDF Download started...",
                                gravity: ToastGravity.BOTTOM);
                            _launchURL(applicant['cvUrl']);
                          },
                          child: ApplicantCard(
                              appliedBy: applicant['appliedBy'],
                              cvFileName: applicant['cvFileName'],
                              cvUrl: applicant['cvUrl'],
                              appliedByName: applicant['appliedByName'],
                              index: index),
                        );
                      });
            },
          ),
        ),
      ),
    );
  }

  void _launchURL(url) async => await canLaunch(url)
      ? await launch(url)
      : Fluttertoast.showToast(msg: "Could not launch $url");
}
