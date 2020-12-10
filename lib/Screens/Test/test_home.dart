import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'testSubjects.dart';

class TestHome extends StatelessWidget {
  @override
  Widget categoryButton(String category, BuildContext context) {
    return OutlineButton(
      onPressed: () {
        if (category == category)
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TestSubject(
                        category: category,
                      )));
        else {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Not implemented yet"),
            duration: Duration(seconds: 1),
          ));
        }
      },
      // onPressed: () => print(category),
      child: Text(
        category,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      borderSide: BorderSide(color: Color(0xFF3EC3C1), width: 2.0),
    );
  }

  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              "Category",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: deviceHeight / 15,
          ),
          Row(
            children: [
              SizedBox(
                width: deviceWidth / 7,
              ),
              categoryButton("ICAR UG", context),
              SizedBox(
                width: deviceWidth / 4,
              ),
              categoryButton("ICAR JRF", context),
            ],
          ),
          SizedBox(
            height: deviceHeight / 15,
          ),
          Row(
            children: [
              SizedBox(
                width: deviceWidth / 7,
              ),
              categoryButton("ICAR SRF", context),
              SizedBox(
                width: deviceWidth / 4,
              ),
              categoryButton("NET", context),
            ],
          ),
          SizedBox(
            height: deviceHeight / 15,
          ),
          Row(
            children: [
              SizedBox(
                width: deviceWidth / 7,
              ),
              categoryButton("BHU", context),
              SizedBox(
                width: deviceWidth / 4,
              ),
              categoryButton("AFO", context),
            ],
          ),
        ],
      ),
    );
  }
}
