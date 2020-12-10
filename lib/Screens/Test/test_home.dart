import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'testSubjects.dart';

class TestHome extends StatelessWidget {
  Widget categoryButton(String category, BuildContext context) {
    return ButtonTheme(
      minWidth: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.width * 0.2,
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
          child: Text(
            category,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          borderSide: BorderSide(color: Color(0xFF3EC3C1), width: 10.0)),
    );
  }

  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              categoryButton("ICAR UG", context),
              categoryButton("ICAR JRF", context),
            ],
          ),
          SizedBox(
            height: deviceHeight / 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              categoryButton("ICAR SRF", context),
              categoryButton("NET", context),
            ],
          ),
          SizedBox(
            height: deviceHeight / 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              categoryButton("BHU", context),
              categoryButton("AFO", context),
            ],
          ),
        ],
      ),
    );
  }
}
