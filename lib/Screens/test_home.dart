import 'package:flutter/material.dart';

class TestHome extends StatelessWidget {
  @override
  Widget categoryButton(String category) {
    return RaisedButton(
      onPressed: () => print(category),
      child: Text(
        category,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
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
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
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
              categoryButton("IAS"),
              SizedBox(
                width: deviceWidth / 4,
              ),
              categoryButton("IPS"),
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
              categoryButton("WBCS"),
              SizedBox(
                width: deviceWidth / 4,
              ),
              categoryButton("WB SI"),
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
              categoryButton("NAVY"),
              SizedBox(
                width: deviceWidth / 4,
              ),
              categoryButton("RAIL"),
            ],
          )
        ],
      ),
    );
  }
}
