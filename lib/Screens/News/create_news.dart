import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateNews extends StatefulWidget {
  @override
  _CreateNewsState createState() => _CreateNewsState();
}

class _CreateNewsState extends State<CreateNews> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  final _uid = FirebaseAuth.instance.currentUser.uid;
  final _uname = FirebaseAuth.instance.currentUser.displayName;
  bool _isApproved = false;
  String _newsTitle = "";
  String _description = "";
  String _imageUrl = "";
  String _fileUrl = "";

  Future _fileImagePicker(BuildContext context) async {
    File file;
    String filename = "";
    try {
      FilePickerResult result =
          await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null) {
        file = File(result.files.first.path);
        setState(() {
          filename = basename(file.path);
        });
        _uploadImageFile(context, file, filename);
      }
    } on PlatformException catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Sorry .."),
              content: Text('Unsupported exception : $e'),
              actions: <Widget>[
                FlatButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ],
            );
          });
    }
  }

  Future<void> _uploadImageFile(
      BuildContext context, File file, String filename) async {
    Reference storageReference;
    storageReference =
        FirebaseStorage.instance.ref().child("news/images/$filename");
    final UploadTask uploadTask = storageReference.putFile(file);
    uploadTask.whenComplete(() async {
      try {
        await storageReference.getDownloadURL().then((value) {
          setState(() {
            _imageUrl = value;
          });
        });

        Fluttertoast.showToast(msg: "Image uploaded successfully");
      } catch (e) {
        setState(() {
          showUploadButton = true;
        });
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Sorry,error in uploading file...Try again"),
                content: Text('Unsupported exception : $e'),
                actions: <Widget>[
                  FlatButton(
                      child: Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      })
                ],
              );
            });
      }
    });
  }

  Future _filePicker(BuildContext context) async {
    File file;
    String filename = "";
    try {
      FilePickerResult result = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: [
        'pdf',
        'GIF',
        'doc',
        'tiff',
        'xls',
        'csv',
      ]);
      if (result != null) {
        file = File(result.files.first.path);
        setState(() {
          filename = basename(file.path);
        });
        _uploadFile(context, file, filename);
      }
    } on PlatformException catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Sorry .."),
              content: Text('Unsupported exception : $e'),
              actions: <Widget>[
                FlatButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ],
            );
          });
    }
  }

  Future<void> _uploadFile(
      BuildContext context, File file, String filename) async {
    Reference storageReference;
    storageReference =
        FirebaseStorage.instance.ref().child("news/files/$filename");
    final UploadTask uploadTask = storageReference.putFile(file);
    uploadTask.whenComplete(() async {
      try {
        await storageReference.getDownloadURL().then((value) {
          setState(() {
            _fileUrl = value;
          });
        });
        Fluttertoast.showToast(msg: "File uploaded successfully");
      } catch (e) {
        setState(() {
          showUploadButton = true;
        });
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Sorry,error in uploading file...Try again"),
                content: Text('Unsupported exception : $e'),
                actions: <Widget>[
                  FlatButton(
                      child: Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      })
                ],
              );
            });
      }
    });
  }

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

  final TextEditingController dobController = TextEditingController();
  String dob = "";

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
                inputFormatters: [LengthLimitingTextInputFormatter(30)],
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
              SizedBox(
                height: height * 0.1,
              ),
              Visibility(
                visible: showUploadButton,
                child: OutlineButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  child: Text("Upload Image"),
                  onPressed: () {
                    loadProgress();
                    showUploadButton = false;
                    _fileImagePicker(context);
                  },
                ),
              ),
              SizedBox(
                height: height * 0.1,
              ),
              Visibility(
                child: OutlineButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  child: Text("Upload File"),
                  onPressed: () {
                    loadProgress();
                    showUploadButton = false;
                    _filePicker(context);
                  },
                ),
              ),
              SizedBox(
                height: height * 0.1,
              ),
              RaisedButton(
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
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    await FirebaseFirestore.instance.collection("News").add({
                      "isApprovedByAdmin": _isApproved,
                      "uid": _uid,
                      "uname": _uname != null ? _uname : "",
                      "title": _newsTitle,
                      "postedAt": _selectedDate.toString(),
                      "description": _description,
                      "imageUrl": _imageUrl,
                      "fileUrl": _fileUrl
                    });
                  }
                },
              ),
            ]),
      ),
    );
  }
}
