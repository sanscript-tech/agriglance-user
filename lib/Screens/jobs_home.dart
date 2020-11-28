import 'package:agriglance/Screens/add_jobs.dart';
import 'package:agriglance/constants/job_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class JobsHome extends StatefulWidget {
  @override
  _JobsHomeState createState() => _JobsHomeState();
}

class _JobsHomeState extends State<JobsHome> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("jobs").snapshots(),
          builder: (context, snapshot) {
            return !snapshot.hasData
                ? Text("Loading")
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
                        );
                      }
                    },
                  );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddJobs(
                    uid: auth.currentUser.uid,
                    uName: auth.currentUser.displayName))),
        child: Icon(Icons.add),
      ),
    );
  }
}
