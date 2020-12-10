import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddStudyMaterial extends StatefulWidget {
  String uid;
  String uName;

  AddStudyMaterial({this.uid, this.uName});

  @override
  _AddStudyMaterialState createState() => _AddStudyMaterialState();
}

class _AddStudyMaterialState extends State<AddStudyMaterial> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _title;
  String _description;
  String _pdfUrl;
  String _subject = "Choose Subject";
  FilePickerResult _filePickerResult;
  String absolutePath = "";
  String fileName = "";
  String fileUrl = "";
  File file;
  bool showUploadButton = true;
  String dropdownValue = "Choose Type";
  List<String> subjectList;

  @override
  void initState() {
    super.initState();
    subjectList = List<String>();
    setState(() {
      subjectList.add("Choose Subject");
    });
    fetchSubjectList();
  }

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
    await FirebaseFirestore.instance.collection("study_materials").add({
      'isApprovedByAdmin': false,
      'type': dropdownValue,
      'title': _title,
      'description': _description,
      'pdfUrl': _pdfUrl,
      'fileName': fileName,
      'subject': _subject,
      'postedBy': widget.uid,
      'postedByName': widget.uName == null ? "" : widget.uName
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
        body: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            children: [
              DropdownButtonFormField<String>(
                value: dropdownValue,
                decoration: InputDecoration(
                  icon: Icon(Icons.category, color: Colors.grey),
                ),
                validator: (value) =>
                    value == "Choose Type" ? "Choose material Type" : null,
                hint: Text("Choose Type"),
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
                items: <String>[
                  "Choose Type",
                  'Research Paper',
                  'Question Paper',
                  'Book/Article',
                  'Other'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              DropdownButtonFormField<String>(
                value: _subject,
                decoration: InputDecoration(
                  icon: Icon(Icons.science, color: Colors.grey),
                ),
                validator: (value) =>
                    value == "Choose Subject" ? "Choose Valid Subject" : null,
                hint: Text("Choose Subject"),
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                onChanged: (String newValue) {
                  setState(() {
                    _subject = newValue;
                  });
                },
                items: subjectList.map<DropdownMenuItem<String>>((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              TextFormField(
                inputFormatters: [LengthLimitingTextInputFormatter(100)],
                validator: (val) => val.isEmpty ? 'Title is Required' : null,
                onSaved: (val) => _title = val,
                decoration: InputDecoration(
                  icon: Icon(Icons.edit),
                  hintText: 'Enter the title',
                  labelText: 'Title',
                ),
              ),
              TextFormField(
                inputFormatters: [LengthLimitingTextInputFormatter(300)],
                onSaved: (val) => _description = val,
                decoration: InputDecoration(
                  icon: Icon(Icons.book),
                  hintText: 'Describe(optional)',
                  labelText: 'Description',
                ),
              ),
              Container(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height / 20),
                child: OutlineButton(
                  splashColor: Colors.yellow,
                  onPressed: () {
                    if (dropdownValue != "Choose Type") {
                      setState(() {
                        getPDF();
                      });
                    } else {
                      Fluttertoast.showToast(
                          msg: "Choose a valid type",
                          gravity: ToastGravity.BOTTOM);
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  borderSide: BorderSide(color: Color(0xFF3EC3C1), width: 2.0),
                  child: Text(
                    'Select PDF',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Center(
                  child: Text(
                "File selected : $absolutePath",
                style: TextStyle(fontSize: 16.0),
              )),
              Visibility(
                visible: showUploadButton,
                child: Container(
                  padding: EdgeInsets.all(40.0),
                  child: OutlineButton(
                    onPressed: () {
                      setState(() {
                        loadProgress();
                        showUploadButton = false;
                        uploadStarted();
                      });
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    borderSide:
                        BorderSide(color: Color(0xFF3EC3C1), width: 2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Upload PDF',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
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
          FirebaseStorage.instance.ref().child("studyMaterials/" + fileName);
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

  void fetchSubjectList() async {
    QuerySnapshot _myDoc =
        await FirebaseFirestore.instance.collection("testSubjects").get();
    List<DocumentSnapshot> _myDocCount = _myDoc.docs;
    for (int j = 0; j < _myDocCount.length; j++) {
      DocumentSnapshot i = _myDocCount[j];
      setState(() {
        subjectList.add(i.id.trim());
      });
    }
  }
}
