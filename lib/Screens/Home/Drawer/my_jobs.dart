import 'package:agriglance/Screens/Home/Drawer/myJobShowApplications.dart';
import 'package:agriglance/constants/my_job_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyJobs extends StatefulWidget {
  @override
  _MyJobsState createState() => _MyJobsState();
}

class _MyJobsState extends State<MyJobs> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Jobs"),
      ),
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("jobs")
              .where("postedBy", isEqualTo: auth.currentUser.uid.toString())
              .orderBy("isApprovedByAdmin", descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            return !snapshot.hasData
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot jobs = snapshot.data.documents[index];
                      return MyJobCard(
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
                    });
          },
        ),
      ),
    );
  }
}
