import 'package:flutter/material.dart';

class JobDetails extends StatefulWidget {
  String jobType;
  String orgName;
  String jobDesc;
  String jobSubject;
  String jobSkills;
  int jobPosts;
  String salary;
  String orgLink;
  String postedByName;
  JobDetails(
      {this.jobDesc,
      this.jobPosts,
      this.jobSkills,
      this.jobSubject,
      this.jobType,
      this.orgLink,
      this.orgName,
      this.salary,
      this.postedByName});
  @override
  _JobDetailsState createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text("Apply For Job"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(
              height: deviceHeight / 20,
            ),
            Row(
              children: [
                Container(
                  width: deviceWidth,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Org Name :",
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${widget.orgName}",
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Job Type :",
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${widget.jobType}",
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Job Desc :",
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Container(
                              width: deviceWidth / 1.4,
                              child: Text(
                                "${widget.jobDesc}",
                                style: TextStyle(fontSize: 20.0),
                                maxLines: 10,
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Skills :",
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Container(
                              width: deviceWidth / 1.4,
                              child: Text(
                                "${widget.jobSkills}",
                                style: TextStyle(fontSize: 20.0),
                                maxLines: 10,
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "No. of posts :",
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${widget.jobPosts}",
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Salary :",
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Rs.${widget.salary}/month",
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: deviceHeight / 10,
            ),
            RaisedButton(
              child: Text(
                "Apply",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () => print("Applied for job"),
            )
          ],
        ));
  }
}
