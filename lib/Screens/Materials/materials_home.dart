import 'package:agriglance/Screens/StudyMaterials/study_materials__home.dart';
import 'package:flutter/material.dart';

class MaterialsHome extends StatelessWidget {
  @override
  Widget categoryButton(String category, BuildContext context) {
    return RaisedButton(
      onPressed: () {
        switch (category) {
          case "Study Materials":
            {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StudyMaterialsHome()));
            }
            break;
          default:
            {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("Not implemented yet"),
                duration: Duration(seconds: 1),
              ));
            }
        }
      },
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
              categoryButton("Videos", context),
              SizedBox(
                width: deviceWidth / 7,
              ),
              categoryButton("Study Materials", context),
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
              categoryButton("News and Current Affairs", context),
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
              categoryButton("Polls", context),
            ],
          )
        ],
      ),
    );
  }
}
