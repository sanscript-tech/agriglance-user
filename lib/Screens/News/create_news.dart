import 'dart:io';
import 'dart:math';
import 'package:agriglance/Models/usermodel.dart';
import 'package:agriglance/Services/firestore_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:universal_html/html.dart' as html;

class CreateNews extends StatefulWidget {
  @override
  _CreateNewsState createState() => _CreateNewsState();
}

class _CreateNewsState extends State<CreateNews> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  final _uid = FirebaseAuth.instance.currentUser.uid;
  String _uname;
  FilePickerResult _filePickerResult;
  bool _isApproved = false;
  String _newsTitle = "";
  String _description = "";
  String _link = "";
  String _fileUrl;
  String absolutePath = "";
  String fileName = "";
  var file;

  bool visible = false;
  bool showUploadButton = true;

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

  final TextEditingController dateController = TextEditingController();
  String date = "";

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add News"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[
              TextFormField(
                inputFormatters: [LengthLimitingTextInputFormatter(50)],
                keyboardType: TextInputType.text,
                validator: (val) =>
                    val.isEmpty ? 'News title is required' : null,
                onSaved: (val) => _newsTitle = val,
                decoration: InputDecoration(
                  hintText: 'Enter News title',
                  icon: Icon(Icons.map),
                  labelText: 'News title',
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                validator: (val) =>
                    val.isEmpty ? 'News description is required' : null,
                onSaved: (val) => _description = val,
                decoration: InputDecoration(
                    hintText: 'Enter description',
                    labelText: 'Description',
                    icon: Icon(Icons.description)),
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                onSaved: (val) => _link = val,
                decoration: InputDecoration(
                    hintText: 'Enter News Link(optional)',
                    labelText: 'News Link',
                    icon: Icon(Icons.link)),
              ),
              SizedBox(
                height: height * 0.1,
              ),
              Container(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height / 20),
                child: OutlineButton(
                  splashColor: Colors.yellow,
                  onPressed: () {
                    setState(() {
                      getPDF();
                    });
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  borderSide: BorderSide(color: Color(0xFF3EC3C1), width: 2.0),
                  child: Text(
                    'Select File',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              Center(
                  child: Text(
                "File selected : $absolutePath",
                style: TextStyle(fontSize: 16.0),
              )),
              Visibility(
                visible: showUploadButton,
                child: OutlineButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  child: Text("Upload File"),
                  onPressed: () {
                    loadProgress();
                    showUploadButton = false;
                    uploadStarted();
                  },
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
              SizedBox(
                height: height * 0.1,
              ),
              Visibility(
                visible: _fileUrl == null ? false : true,
                child: RaisedButton(
                  splashColor: Colors.grey,
                  color: Colors.yellow,
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
                      ]),
                  onPressed: () async {
                    loadProgress();
                    UserModel updateUser = await FirestoreService()
                        .getUser(FirebaseAuth.instance.currentUser.uid);
                    setState(() {
                      _uname = updateUser.fullName;
                    });
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      await FirebaseFirestore.instance.collection("News").add({
                        "isApprovedByAdmin": _isApproved,
                        "uid": _uid,
                        "uname": _uname != null ? _uname : "",
                        "title": _newsTitle,
                        "newsLink": _link,
                        "postedAt": _selectedDate.toString(),
                        "description": _description,
                        "fileUrl": _fileUrl
                      }).then((value) {
                        Navigator.pop(context);
                      });
                    }
                  },
                ),
              ),
            ]),
      ),
    );
  }

  Future getPDF() async {
    var random = new Random();
    for (var i = 0; i < 20; i++) {
      print(random.nextInt(100));
      fileName += random.nextInt(100).toString();
    }
    if (!kIsWeb) {
      _filePickerResult = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowMultiple: false,
          allowedExtensions: ['jpg', 'png', 'jpeg'],
          allowCompression: true);
      if (_filePickerResult != null) {
        setState(() {
          file = File(_filePickerResult.files.single.path);
          List<String> p = file.path.split("/").toList();
          absolutePath = file.path.split("/")[p.length - 1];
          fileName += '$absolutePath';
        });
      }
    } else {
      html.InputElement uploadInput = html.FileUploadInputElement();
      uploadInput.click();

      uploadInput.onChange.listen((e) {
        final userFile = uploadInput.files.first;
        final reader = html.FileReader();
        reader.readAsDataUrl(userFile);
        reader.onLoadEnd.listen((event) {
          setState(() {
            file = userFile;
            absolutePath = userFile.name;
            fileName += absolutePath;
          });
        });
      });
    }
  }

  Future uploadStarted() async {
    if (file != null) {
      Reference storageReference =
          FirebaseStorage.instance.ref().child("news/files/" + fileName);
      UploadTask uploadTask;
      if (kIsWeb) {
        uploadTask = storageReference.putBlob(file);
      } else {
        uploadTask = storageReference.putFile(file);
      }
      uploadTask.whenComplete(() async {
        try {
          loadProgress();
          await storageReference.getDownloadURL().then((value) {
            print("***********" + value + "**********");
            setState(() {
              _fileUrl = value;
            });
          });
        } catch (onError) {
          print("Error in uploading file: " + onError.message);
        }
      });
    }
  }
}
