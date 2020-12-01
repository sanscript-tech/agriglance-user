import 'package:agriglance/Screens/Jobs/job_details.dart';
import 'package:flutter/material.dart';

class JobCard extends StatefulWidget {
  String jobType;
  String orgName;
  String jobDesc;
  String jobSubject;
  String jobSkills;
  int jobPosts;
  String salary;
  String orgLink;
  String postedByName;
  int index;
  String jobId;

  JobCard(
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
  _JobCardState createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      height: deviceHeight / 7,
      padding: EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => JobDetails(
                      jobDesc: widget.jobDesc,
                      jobPosts: widget.jobPosts,
                      jobSkills: widget.jobSkills,
                      jobSubject: widget.jobSubject,
                      jobType: widget.jobType,
                      orgLink: widget.orgLink,
                      orgName: widget.orgName,
                      salary: widget.salary,
                      postedByName: widget.postedByName,
                      jobId: widget.jobId,
                    ))),
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
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
