import 'package:agriglance/Screens/Polls/poll_home.dart';
import 'package:agriglance/Screens/StudyMaterials/study_materials__home.dart';
import 'package:agriglance/Screens/Videos/video_home.dart';
import 'package:flutter/material.dart';
import '../News/news_home.dart';

class MaterialsHome extends StatelessWidget {
  @override
  Widget categoryButton(
      String category, BuildContext context, Widget newScreen) {
    return RaisedButton(
      onPressed: () {
        switch (category) {
          case "Study Materials":
            {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => newScreen));
              break;
            }
          case "Videos":
            {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => VideoHome()));
              break;
            }
          case "News and Current Affairs":
            {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => NewsHome()));
              break;
            }

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
              categoryButton("Videos", context, PollHome()),
              SizedBox(
                width: deviceWidth / 7,
              ),
              categoryButton("Study Materials", context, StudyMaterialsHome()),
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
              categoryButton("News and Current Affairs", context, PollHome()),
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
              RaisedButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PollHome())),
                child: Text(
                  "Polls",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
              )
            ],
          )
        ],
      ),
    );
  }
}
