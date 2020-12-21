import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'testSubjects.dart';

class TestHome extends StatefulWidget {
  @override
  _TestHomeState createState() => _TestHomeState();
}

List<String> _category_names = [];

class _TestHomeState extends State<TestHome> {
  void getCategories() async {
    await FirebaseFirestore.instance
        .collection("testCategories")
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                _category_names.add(doc['category']);
              })
            });
  }

  @override
  void initState() {
    // TODO: implement initState
    getCategories();
    print(_category_names);
    super.initState();
  }

  Widget categoryButton(String category, BuildContext context) {
    var style;
    if (kIsWeb)
      style = TextStyle(fontSize: 30.0, fontWeight: FontWeight.w400);
    else
      style = TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400);
    return ButtonTheme(
      minWidth: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.width * 0.09,
      hoverColor: Colors.amber[200],
      child: OutlineButton(
          splashColor: Colors.grey,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TestSubject(
                          category: category,
                        )));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.menu_book_outlined,
                  size: 40.0, color: Color(0xFF3EC3C1)),
              Text(
                category,
                style: style,
              ),
              Icon(Icons.arrow_forward, size: 40.0, color: Color(0xFF3EC3C1))
            ],
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          borderSide: BorderSide(color: Color(0xFF3EC3C1), width: 6.0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Center(
        child: Container(
            width: deviceWidth * 0.9,
            height: deviceHeight * 0.9,
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
            ], color: Colors.white, border: Border.all(color: Colors.white)),
            child: Center(
              child: GridView.builder(
                  itemCount: _category_names.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                  itemBuilder: (context, index) {
                    return categoryButton(_category_names[index], context);
                  }),
            )),
      ),
    );
  }
}
