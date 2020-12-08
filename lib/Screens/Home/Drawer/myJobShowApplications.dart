
import 'dart:isolate';
import 'dart:ui';

import 'package:agriglance/constants/applicant_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class MyJobShowApplications extends StatefulWidget {
  String jobId;

  MyJobShowApplications({this.jobId});

  @override
  _MyJobShowApplicationsState createState() => _MyJobShowApplicationsState();
}

class _MyJobShowApplicationsState extends State<MyJobShowApplications> {

  final FirebaseAuth auth = FirebaseAuth.instance;
  var _permissionStatus;

  void _listenForPermissionStatus() async {
    final status = await Permission.storage.request().isGranted;
    setState(() => _permissionStatus = status);
  }

  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();
    _listenForPermissionStatus();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
    IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Applications"),
      ),
      body: Container(
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
                      DocumentSnapshot applicant = snapshot.data.documents[index];
                      return GestureDetector(
                        onTap: (){
                          if (_permissionStatus) {
                            Fluttertoast.showToast(
                                msg: "PDF Download started...", gravity: ToastGravity.BOTTOM);
                            // downloadPDF(papers['title'], papers['fileName']);
                            download(applicant['cvUrl'], applicant['cvFileName']);
                          } else {
                            Fluttertoast.showToast(
                                msg: "PDF Download Failed...", gravity: ToastGravity.BOTTOM);
                          }
                        },
                        child: ApplicantCard(
                            appliedBy : applicant['appliedBy'],
                            cvFileName : applicant['cvFileName'],
                            cvUrl : applicant['cvUrl'],
                            appliedByName : applicant['appliedByName'],
                            index : index
                        ),
                      );
                    });
          },
        ),
      ),
    );
  }

  Future<void> download(String url, String fileName) async {
    final taskId = await FlutterDownloader.enqueue(
        url: url,
        savedDir:
        await getExternalStorageDirectory().then((value) => value.path),
        showNotification: true,
        openFileFromNotification: true,
        fileName: fileName);
    await FlutterDownloader.open(taskId: taskId);
  }
}
