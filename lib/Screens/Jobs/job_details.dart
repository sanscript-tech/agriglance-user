import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  String jobId;

  JobDetails(
      {this.jobDesc,
      this.jobPosts,
      this.jobSkills,
      this.jobSubject,
      this.jobType,
      this.orgLink,
      this.orgName,
      this.salary,
      this.postedByName,
      this.jobId});

  @override
  _JobDetailsState createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _pdfUrl;
  FilePickerResult _filePickerResult;
  String absolutePath = "";
  String fileName = "";
  String fileUrl = "";
  File file;
  bool showUploadButton = true;

  Future _uploadFileCV() async {
    if (_filePickerResult != null) {
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child("job_applications/${widget.jobId}/applicants/" + fileName);
      UploadTask uploadTask = storageReference.putFile(file);
      uploadTask.whenComplete(() async {
        try {
          loadProgress();
          await storageReference.getDownloadURL().then((value) {
            print("***********" + value + "**********");
            setState(() {
              _pdfUrl = value;
              FirebaseFirestore.instance
                  .collection("jobs")
                  .doc("${widget.jobId}")
                  .collection("applicants")
                  .doc(FirebaseAuth.instance.currentUser.uid)
                  .set({
                // .collection("applicationDetails")
                // .add({
                'cvUrl': _pdfUrl,
                'cvFileName': fileName,
                'appliedBy': FirebaseAuth.instance.currentUser.uid,
                'appliedByName': FirebaseAuth.instance.currentUser.displayName,
              });
            });
          });
        } catch (onError) {
          print("Error in uploading file: " + onError.message);
        }
      });
    } else {
      showMessage("No file Selected!");
    }
  }

  void showMessage(String message, [MaterialColor color = Colors.red]) {
    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
  }

  bool visible = false;

  loadProgress() {
    if (visible == true) {
      setState(() {
        visible = false;
      });
    } else {
      setState(() {
        visible = true;
      });
    }
  }

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
            Container(
              padding: EdgeInsets.all(20.0),
              child: RaisedButton(
                splashColor: Colors.yellow,
                color: Colors.blue,
                onPressed: () {
                  setState(() {
                    selectCV();
                  });
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Select CV',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(child: Text("File selected : $absolutePath")),
            Visibility(
              visible: showUploadButton,
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: RaisedButton(
                  splashColor: Colors.yellow,
                  color: Colors.blue,
                  onPressed: () {
                    setState(() {
                      loadProgress();
                      showUploadButton = false;
                      _uploadFileCV();
                      if (_pdfUrl != null) {
                        Navigator.pop(context);
                      }
                    });
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Submit Application',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(visible: visible, child: CircularProgressIndicator()),
            Visibility(
                visible: visible,
                child: Text("Uploading your file.. Please wait. Do not navigate back.")),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Visibility(
                visible: _pdfUrl != null ? true : false,
                child: Center(
                  child: Icon(
                    Icons.done_outline_sharp,
                    color: Colors.lightGreen,
                    size: 100,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Visibility(
                visible: _pdfUrl != null ? true : false,
                child: Center(
                  child: Text("Successfully applied!"
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Future selectCV() async {
    var random = new Random();
    for (var i = 0; i < 20; i++) {
      print(random.nextInt(100));
      fileName += random.nextInt(100).toString();
    }
    _filePickerResult = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: ['pdf'],
        allowCompression: true);
    if (_filePickerResult != null) {
      setState(() {
        file = File(_filePickerResult.files.single.path);
        List<String> p = file.path.split("/").toList();
        absolutePath = file.path.split("/")[p.length - 1];
        fileName += '$absolutePath';
      });
    } else {
      showMessage("No file Selected!");
    }
  }
}
