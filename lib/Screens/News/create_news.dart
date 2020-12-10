import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
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
  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate, // Refer step 1
        firstDate: DateTime(2000),
        lastDate: DateTime(2050),
        initialDatePickerMode: DatePickerMode.day,
        helpText: "Select News Date");
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

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

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: const Text("Image uploaded successfully")));
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
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: const Text("File uploaded successfully")));
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

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add News"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: ListView(children: <Widget>[
          Text("New Title"),
          SizedBox(
            height: height * 0.01,
          ),
          TextFormField(
            inputFormatters: [LengthLimitingTextInputFormatter(30)],
            keyboardType: TextInputType.text,
            validator: (val) => val.isEmpty ? 'News title is required' : null,
            onSaved: (val) => _newsTitle = val,
            decoration: InputDecoration(
              hintText: 'Enter News title',
              labelText: 'News title',
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Text("Enter date"),
          MaterialButton(
            onPressed: () {
              _selectDate(context);
            },
            child: Text(
                "${_selectedDate.day}-${_selectedDate.month}-${_selectedDate.year}"),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            validator: (val) =>
                val.isEmpty ? 'News description is required' : null,
            onSaved: (val) => _description = val,
            decoration: InputDecoration(
              hintText: 'Enter description',
              labelText: 'Description',
            ),
          ),
          SizedBox(
            height: height * 0.1,
          ),
          Visibility(
            visible: showUploadButton,
            child: OutlineButton(
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
            child: Text("Submit"),
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
      )),
    );
  }
}
