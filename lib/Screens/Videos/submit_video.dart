import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SubmitVideo extends StatefulWidget {
  @override
  _SubmitVideoState createState() => _SubmitVideoState();
}

class _SubmitVideoState extends State<SubmitVideo> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  String _lectureTitle = "";
  String _youtubeChannelKey = "";
  String _embedVideo = "";
  bool _isApproved = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text("Submit Video"), centerTitle: true),
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: ListView(children: <Widget>[
          TextFormField(
            inputFormatters: [LengthLimitingTextInputFormatter(30)],
            keyboardType: TextInputType.text,
            validator: (val) =>
                val.isEmpty ? 'Lecture title is required' : null,
            onSaved: (val) => _lectureTitle = val,
            decoration: InputDecoration(
              hintText: 'Enter lecture title',
              labelText: 'Lecture title',
            ),
          ),
          SizedBox(
            height: height * 0.1,
          ),
          Text("Enter youtube channel key or embed youtube video url beneath"),
          SizedBox(
            height: height * 0.1,
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            onSaved: (val) => _youtubeChannelKey = val,
            decoration: InputDecoration(
              hintText: 'Enter Youtube channel key',
              labelText: 'Youtube channel key',
            ),
          ),
          SizedBox(
            height: height * 0.1,
          ),
          TextFormField(
            keyboardType: TextInputType.url,
            onSaved: (val) => _embedVideo = val,
            decoration: InputDecoration(
              hintText: 'Enter youtube video url',
              labelText: 'Youtube video url',
            ),
          ),
          SizedBox(
            height: height * 0.1,
          ),
          RaisedButton(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: BorderSide(color: Colors.black87),
              ),
              splashColor: Colors.purple,
              elevation: 10.0,
              highlightElevation: 30.0,
              child: const Text(
                'Submit',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 20.0,
                ),
              ),
              color: Colors.yellow[200],
              textColor: Colors.white,
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  await FirebaseFirestore.instance.collection("Videos").add({
                    "isApprovedByAdmin": _isApproved,
                    "lectureTitle": _lectureTitle,
                    "videoUrl": _embedVideo,
                    "youtubeChannelName": _youtubeChannelKey
                  });

                  _formKey.currentState.reset();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: const Text("Details Submitted Successfully")));
                }
              }),
        ]),
      )),
    );
  }
}
