import 'package:agriglance/Screens/Home/Drawer/myJobShowApplications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyJobCard extends StatefulWidget {
  final String jobType;
  final String orgName;
  final String jobDesc;
  final String jobSubject;
  final String jobSkills;
  final int jobPosts;
  final String salary;
  final String orgLink;
  final String postedByName;
  final int index;
  final String jobId;

  MyJobCard(
      {this.jobDesc,
      this.jobPosts,
      this.jobSkills,
      this.jobSubject,
      this.jobType,
      this.orgLink,
      this.orgName,
      this.salary,
      this.postedByName,
      this.index,
      this.jobId});

  @override
  _MyJobCardState createState() => _MyJobCardState();
}

class _MyJobCardState extends State<MyJobCard> {
  int count = 0;
  @override
  void initState() {
    super.initState();
    countDocuments();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyJobShowApplications(jobId: widget.jobId,))),
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.index + 1}. ${widget.orgName}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  "Salary: " + widget.salary,
                  style: TextStyle(fontSize: 18.0),
                ),
                (widget.postedByName != null)
                    ? Text(
                        "Posted By: " + widget.postedByName,
                        style: TextStyle(fontSize: 16.0),
                      )
                    : Text(
                        "Posted By : Anonymous",
                        style: TextStyle(fontSize: 16.0),
                      ),
                Text("${count.toString()} applicants")
              ],
            ),
          ),
        ),
      ),
    );
  }
  void countDocuments() async {
    QuerySnapshot _myDoc = await FirebaseFirestore.instance
        .collection("jobs")
        .doc(widget.jobId)
        .collection("applicants")
        .get();
    List<DocumentSnapshot> _myDocCount = _myDoc.docs;
    setState(() {
      count = _myDocCount.length;
    });
  }
}
