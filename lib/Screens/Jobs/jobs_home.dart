import 'package:agriglance/Screens/Jobs/add_jobs.dart';
import 'package:agriglance/Screens/Materials/materials_home.dart';
import 'package:agriglance/constants/job_card.dart';
import 'package:agriglance/services/admob_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class JobsHome extends StatefulWidget {
  static const String route="jobs";
  @override
  _JobsHomeState createState() => _JobsHomeState();
}

class _JobsHomeState extends State<JobsHome> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final ams = AdMobService();
    return Scaffold(
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
                .orderBy("isApprovedByAdmin", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot jobs = snapshot.data.documents[index];
                        if (jobs['isApprovedByAdmin']) {
                          return JobCard(
                            jobDesc: jobs['jobSelectionProcedure'],
                            jobPosts: jobs['noOfPosts'],
                            jobSkills: jobs['qualificationsRequired'],
                            jobSubject: jobs['jobSubject'],
                            jobType: jobs['jobType'],
                            orgLink: jobs['organizationLink'],
                            orgName: jobs['organizationName'],
                            salary: jobs['jobSalary'],
                            postedByName: jobs['postedByName'],
                            index: index,
                            jobId: jobs.id,
                          );
                        }
                        return null;
                      },
                    );
            },
          ),
        ),
      ),
      floatingActionButton: (FirebaseAuth.instance.currentUser != null)
          ? FloatingActionButton(
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
                print("No of clicks $noOfClicks");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddJobs(
                            uid: auth.currentUser.uid,
                            uName: auth.currentUser.displayName)));
              },
              child: Icon(Icons.add),
            )
          : null,
    );
  }
}
