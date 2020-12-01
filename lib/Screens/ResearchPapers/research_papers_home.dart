import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'dart:typed_data';

import 'package:agriglance/Screens/ResearchPapers/add_research_paper.dart';
import 'package:agriglance/constants/research_paper_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ResearchPapersHome extends StatefulWidget {
  @override
  _ResearchPapersHomeState createState() => _ResearchPapersHomeState();
}

class _ResearchPapersHomeState extends State<ResearchPapersHome> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final papersCollectionReference =
      FirebaseStorage.instance.ref().child("researchPapers");
  var _permissionStatus;

  void _listenForPermissionStatus() async {
    final status = await Permission.storage.request().isGranted;
    setState(() => _permissionStatus = status);
  }

  @override
  void initState() {
    super.initState();
    _listenForPermissionStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Research Papers"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddResearchPaper(
                    uid: auth.currentUser.uid,
                    uName: auth.currentUser.displayName))),
        child: Icon(Icons.add),
      ),
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("research_papers")
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
                          onTap: () {
                            if (_permissionStatus) {
                              Fluttertoast.showToast(
                                  msg: "PDF Download started...",
                                  gravity: ToastGravity.BOTTOM);
                              downloadPDF(papers['title'], papers['fileName']);
                            } else {
                              Fluttertoast.showToast(
                                  msg: "PDF Download Failed...",
                                  gravity: ToastGravity.BOTTOM);
                            }
                          },
                          child: ResearchPaperCard(
                            title: papers['title'],
                            description: papers['description'],
                            pdfUrl: papers['pdfUrl'],
                            postedByName: papers['postedByName'],
                            fileName: papers['fileName'],
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

  Future<void> downloadPDF(String paperTitle, String fileName) async {
    Directory appDocDir = await getExternalStorageDirectory();
    String appDocPath = appDocDir.path;
    File _file = File('$appDocPath/$fileName');
    print("FILE PATH: ***************** ${_file.path}");
    Reference _fileRef = papersCollectionReference.child('$fileName');
    DownloadTask _downloadTask = _fileRef.writeToFile(_file);
    TaskSnapshot snap = await _downloadTask;
    print(snap.state);
    prepareTestPdf(_file.path).then((path) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FullPdfViewerScreen(path, paperTitle)),
      );
    });
  }

  Future<String> prepareTestPdf(String _documentPath) async {
    final ByteData bytes =
        await DefaultAssetBundle.of(context).load(_documentPath);
    final Uint8List list = bytes.buffer.asUint8List();

    final tempDir = await getTemporaryDirectory();
    final tempDocumentPath = '${tempDir.path}/$_documentPath';

    final file = await File(tempDocumentPath).create(recursive: true);
    file.writeAsBytesSync(list);
    return tempDocumentPath;
  }
}

class FullPdfViewerScreen extends StatelessWidget {
  String path;
  String paperTitle;
  FullPdfViewerScreen(this.path, this.paperTitle);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
      appBar: AppBar(
        title: Text("$paperTitle"),
      ),
      path: path,
    );
  }
}
