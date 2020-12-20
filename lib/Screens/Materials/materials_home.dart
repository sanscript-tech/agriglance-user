import 'package:agriglance/Screens/Polls/poll_home.dart';
import 'package:agriglance/Screens/StudyMaterials/study_materials__home.dart';
import 'package:agriglance/Screens/Videos/video_home.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../News/news_home.dart';
import '../Quiz/quiz_home.dart';

class MaterialsHome extends StatelessWidget {
  @override
  Widget categoryButton(
      String category, BuildContext context, Widget newScreen) {
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
        onPressed: () {
          switch (category) {
            case "Study Materials":
              {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => newScreen));
                break;
              }
            case "Videos":
              {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => newScreen));
                break;
              }
            case "News and Current Affairs":
              {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => newScreen));
                break;
              }
            case "Polls":
              {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => newScreen));
                break;
              }
            case "Quiz":
              {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => newScreen));
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (category == "Study Materials")
              Icon(Icons.menu_book_outlined, size: 50.0, color: Colors.purple)
            else if (category == "Videos")
              Icon(Icons.videocam, size: 50.0, color: Colors.purple)
            else if (category == "News and Current Affairs")
              Icon(Icons.trending_up, size: 50.0, color: Colors.purple)
            else if (category == "Polls")
              Icon(Icons.poll, size: 50.0, color: Colors.purple)
            else if (category == "Quiz")
              Icon(Icons.lightbulb, size: 50.0, color: Colors.purple),
            Text(
              category,
              style: style,
            ),
          ],
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        borderSide: BorderSide(color: Colors.purple, width: 6.0),
      ),
    );
  }

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
          child: Column(
            children: [
              SizedBox(
                height: deviceHeight / 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  categoryButton("Videos", context, VideoHome()),
                  categoryButton(
                      "Study Materials", context, StudyMaterialsHome()),
                ],
              ),
              SizedBox(
                height: deviceHeight / 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  categoryButton(
                      "News and Current Affairs", context, NewsHome()),
                ],
              ),
              SizedBox(
                height: deviceHeight / 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  categoryButton("Polls", context, PollHome()),
                  categoryButton("Quiz", context, QuizHome())
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
