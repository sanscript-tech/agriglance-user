import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddResearchPaper extends StatefulWidget {
  String uid;
  String uName;

  AddResearchPaper({this.uid, this.uName});

  @override
  _AddResearchPaperState createState() => _AddResearchPaperState();
}

class _AddResearchPaperState extends State<AddResearchPaper> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _title;
  String _description;
  String _pdfUrl;
  FilePickerResult _filePickerResult;
  String absolutePath = "";
  String fileName = "";
  String fileUrl = "";
  File file;
  bool showUploadButton = true;

  void _submitForm() async {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      showMessage('Form is not valid!  Please review and correct.');
    } else {
      form.save();
    }
    _uploadResearchPaper();
    Navigator.pop(context);
  }

  Future<void> _uploadResearchPaper() async {
    await FirebaseFirestore.instance.collection("research_papers").add({
      'isApprovedByAdmin': false,
      'title': _title,
      'description': _description,
      'pdfUrl': _pdfUrl,
      'fileName': fileName,
      'postedBy': widget.uid,
      'postedByName': widget.uName
    });
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
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Research Paper"),
          centerTitle: true,
        ),
        body: SafeArea(
          top: false,
          bottom: false,
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                TextFormField(
                  inputFormatters: [LengthLimitingTextInputFormatter(100)],
                  validator: (val) => val.isEmpty ? 'Title is Required' : null,
                  onSaved: (val) => _title = val,
                  decoration: InputDecoration(
                    icon: Icon(Icons.edit),
                    hintText: 'Enter the title of the research paper',
                    labelText: 'Title',
                  ),
                ),
                TextFormField(
                  inputFormatters: [LengthLimitingTextInputFormatter(100)],
                  onSaved: (val) => _description = val,
                  decoration: InputDecoration(
                    icon: Icon(Icons.book),
                    hintText: 'Describe your paper(optional)',
                    labelText: 'Description',
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: RaisedButton(
                    splashColor: Colors.yellow,
                    color: Colors.blue,
                    onPressed: () {
                      setState(() {
                        getPDF();
                      });
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Select PDF',
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
                          uploadStarted();
                        });
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Upload PDF',
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
                Column(
                  children: [
                    Visibility(
                        visible: visible, child: CircularProgressIndicator()),
                    Visibility(
                        visible: visible,
                        child: Text(
                            "Uploading your file.. Please wait. Do not navigate back."))
                  ],
                ),
                Visibility(
                  visible: _pdfUrl == null ? false : true,
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    child: RaisedButton(
                      splashColor: Colors.grey,
                      color: Colors.yellow,
                      onPressed: () {
                        _submitForm();
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      highlightElevation: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Submit for Admin Approval',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Future getPDF() async {
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

  Future uploadStarted() async {
    if (_filePickerResult != null) {
      Reference storageReference =
          FirebaseStorage.instance.ref().child("researchPapers/" + fileName);
      UploadTask uploadTask = storageReference.putFile(file);
      uploadTask.whenComplete(() async {
        try {
          loadProgress();
          await storageReference.getDownloadURL().then((value) {
            print("***********" + value + "**********");
            setState(() {
              _pdfUrl = value;
            });
          });
        } catch (onError) {
          print("Error in uploading file: " + onError.message);
        }
      });
    }
    showMessage("No file Selected!");
  }
}
