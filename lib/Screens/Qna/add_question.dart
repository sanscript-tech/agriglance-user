import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddQuestionScreen extends StatefulWidget {
  String uid;
  String uName;

  AddQuestionScreen({this.uid, this.uName});

  @override
  _AddQuestionScreenState createState() => _AddQuestionScreenState();
}

class _AddQuestionScreenState extends State<AddQuestionScreen> {
  String _category = "Choose Category";
  String _question = "";
  String _questionDesc = "";
  List<String> categoryList;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    categoryList = List<String>();
    setState(() {
      categoryList.add("Choose Category");
    });
    fetchCategoryList();
  }

  void _submitForm() async {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      showMessage('Form is not valid!  Please review and correct.');
    } else {
      form.save();
    }
    _uploadQuestion();
    Fluttertoast.showToast(
        msg: "Added Successfully", gravity: ToastGravity.BOTTOM);
    Navigator.pop(context);
  }

  Future<void> _uploadQuestion() async {
    await FirebaseFirestore.instance.collection("qna").add({
      'categoryType': _category,
      'question': _question,
      'questionDesc': _questionDesc,
      'postedBy': widget.uid,
      'postedByName': widget.uName,
      'askedOn': DateTime.now(),
    });
  }

  void showMessage(String message, [MaterialColor color = Colors.red]) {
    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Question"),
          centerTitle: true,
        ),
        body: SafeArea(
          top: false,
          bottom: false,
          child: Center(
            child: Container(
              width: 700.0,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 25.0, // soften the shadow
                      spreadRadius: 5.0, //extend the shadow
                      offset: Offset(
                        15.0,
                        15.0,
                      ),
                    )
                  ],
                  color: Colors.yellow[50],
                  border: Border.all(color: Colors.white)),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.always,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  children: [
                    DropdownButtonFormField<String>(
                      value: _category,
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
                          _category = newValue;
                        });
                      },
                      items:
                          categoryList.map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    TextFormField(
                      inputFormatters: [LengthLimitingTextInputFormatter(30)],
                      validator: (val) =>
                          val.isEmpty ? 'Question title is required' : null,
                      onSaved: (val) => _question = val,
                      decoration: InputDecoration(
                        icon: Icon(Icons.question_answer),
                        hintText: 'Enter the title of question',
                        labelText: 'Question',
                      ),
                    ),
                    TextFormField(
                      inputFormatters: [LengthLimitingTextInputFormatter(30)],
                      validator: (val) => val.isEmpty
                          ? 'Question description is required'
                          : null,
                      onSaved: (val) => _questionDesc = val,
                      decoration: InputDecoration(
                        icon: Icon(Icons.subject),
                        hintText: 'Enter the description of question',
                        labelText: 'Question Description',
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 40.0, top: 20.0),
                        child: RaisedButton(
                          child: Text('Add Question'),
                          onPressed: _submitForm,
                        )),
                  ],
                ),
              ),
            ),
          ),
        ));
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
