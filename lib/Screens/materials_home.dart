import 'package:flutter/material.dart';

class MaterialsHome extends StatelessWidget {
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
          SizedBox(
            height: deviceHeight / 15,
          ),
          Row(
            children: [
              SizedBox(
                width: deviceWidth / 7,
              ),
              categoryButton("Videos"),
              SizedBox(
                width: deviceWidth / 7,
              ),
              categoryButton("Researc Paper"),
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
              categoryButton("Current Affairs"),
              SizedBox(
                width: deviceWidth / 7,
              ),
              categoryButton("News"),
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
              categoryButton("Notes"),
              SizedBox(
                width: deviceWidth / 7,
              ),
              categoryButton("Polls"),
            ],
          )
        ],
      ),
    );
  }
}
