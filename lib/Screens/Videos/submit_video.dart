import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  List<String> categoryList;
  String dropdownValue = "Choose category";

  @override
  void initState() {
    super.initState();
    categoryList = List<String>();
    setState(() {
      categoryList.add("Choose category");
    });
    fetchCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text("Submit Video"), centerTitle: true),
      body: Center(
        child: Container(
          width: 700.0,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 25.0, // soften the shadow
              spreadRadius: 5.0, //extend the shadow
              offset: Offset(
                15.0,
                15.0,
              ),
            )
          ], color: Colors.yellow[50], border: Border.all(color: Colors.white)),
          child: Form(
            key: _formKey,
            child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  DropdownButtonFormField<String>(
                    value: dropdownValue,
                    decoration: InputDecoration(
                      icon: Icon(Icons.category, color: Colors.grey),
                    ),
                    validator: (value) => value == "Choose category"
                        ? "Choose Valid Category"
                        : null,
                    hint: Text("Choose category"),
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: categoryList.map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  TextFormField(
                    inputFormatters: [LengthLimitingTextInputFormatter(30)],
                    keyboardType: TextInputType.text,
                    validator: (val) =>
                        val.isEmpty ? 'Lecture title is required' : null,
                    onSaved: (val) => _lectureTitle = val,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 5.0),
                      icon: Icon(Icons.title),
                      hintText: 'Enter lecture title',
                      labelText: 'Lecture Title',
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    onSaved: (val) => _youtubeChannelKey = val,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      hintText: 'Enter Youtube channel key',
                      labelText: 'Youtube Channel Key',
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.url,
                    onSaved: (val) => _embedVideo = val,
                    decoration: InputDecoration(
                      icon: Icon(Icons.link),
                      hintText: 'Enter youtube video url',
                      labelText: 'Youtube video url',
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  OutlineButton(
                      splashColor: Colors.black,
                      borderSide:
                          BorderSide(color: Color(0xFF3EC3C1), width: 2.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 20.0,
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          await FirebaseFirestore.instance
                              .collection("Videos")
                              .add({
                            "isApprovedByAdmin": _isApproved,
                            "lectureTitle": _lectureTitle,
                            "videoUrl": _embedVideo,
                            "category": dropdownValue,
                            "youtubeChannelName": _youtubeChannelKey,
                            "postedBy":
                                FirebaseAuth.instance.currentUser.uid != null
                                    ? FirebaseAuth.instance.currentUser.uid
                                    : "Anonymous"
                          });

                          _formKey.currentState.reset();
                          Fluttertoast.showToast(
                              msg: "Details Submitted Successfully");
                        }
                      }),
                ]),
          ),
        ),
      ),
    );
  }

  Future<void> fetchCategoryList() async {
    QuerySnapshot _myDoc =
        await FirebaseFirestore.instance.collection("testCategories").get();
    List<DocumentSnapshot> _myDocCount = _myDoc.docs;
    for (int j = 0; j < _myDocCount.length; j++) {
      DocumentSnapshot i = _myDocCount[j];
      setState(() {
        categoryList.add(i.id.trim());
      });
    }
    categoryList.add("Other");
  }
}
