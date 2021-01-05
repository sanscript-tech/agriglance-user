import 'package:agriglance/Screens/Documents/documents_home.dart';
import 'package:agriglance/Screens/Images/images_home.dart';
import 'package:agriglance/Screens/Polls/poll_home.dart';
import 'package:agriglance/Screens/QuestionPaper/question_papers_home.dart';
import 'package:agriglance/Screens/StudyMaterials/study_materials__home.dart';
import 'package:agriglance/Screens/Thesis/thesis_home.dart';
import 'package:agriglance/Screens/Videos/video_home.dart';
import 'package:agriglance/services/admob_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:universal_html/prefer_sdk/html.dart';
import 'package:url_launcher/url_launcher.dart';
import '../News/news_home.dart';
import '../Quiz/quiz_home.dart';
import 'package:firebase_admob/firebase_admob.dart';
import '../../route_names.dart';

int noOfClicks = 0;

class MaterialsHome extends StatefulWidget {
  @override
  _MaterialsHomeState createState() => _MaterialsHomeState();
}

class _MaterialsHomeState extends State<MaterialsHome> {
  final ams = (!kIsWeb) ? AdMobService() : null;

  @override
  Widget categoryButton(String category) {
    var style;
    if (kIsWeb)
      style = TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontFamily: 'Times',
      );
    else
      style = TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontFamily: 'Times',
      );
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
          width: 700.0,
          height: 100.0,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue[900],
                  Colors.blue,
                  Colors.red,
                ],
              ),
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
              border: Border.all(color: Colors.white)),
          child: MaterialButton(
              splashColor: Colors.grey,
              hoverColor: Colors.amber,
              onPressed: () {
                if (!kIsWeb && noOfClicks % 5 == 0) {
                  InterstitialAd newAd = ams.getInterstitialAd();
                  newAd.load();
                  newAd.show(
                    anchorType: AnchorType.bottom,
                    anchorOffset: 0.0,
                    horizontalCenterOffset: 0.0,
                  );
                  noOfClicks++;
                }
                noOfClicks++;
                print("No of clicks $noOfClicks");
                switch (category) {
                  case "Study Materials":
                    {
                      Navigator.pushNamed(context, studyMaterials);

                      break;
                    }
                  case "Videos":
                    {
                      Navigator.pushNamed(context, vedios);

                      break;
                    }
                  case "News and Current Affairs":
                    {
                      Navigator.pushNamed(context, news);
                      break;
                    }
                  case "Polls":
                    {
                      Navigator.pushNamed(context, polls);
                      break;
                    }
                  case "Quiz":
                    {
                      Navigator.pushNamed(context, quiz);
                      break;
                    }
                  case "Images":
                    {
                      Navigator.pushNamed(context, images);
                      break;
                    }
                  case "Question Papers":
                    {
                      Navigator.pushNamed(context, questionPapers);
                      break;
                    }
                  case "Documents":
                    {
                      Navigator.pushNamed(context, documents);
                      break;
                    }
                  case "Thesis":
                    {
                      Navigator.pushNamed(context, thesis);
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
                    Icon(Icons.menu_book_outlined, color: Colors.amber[100])
                  else if (category == "Videos")
                    Icon(Icons.videocam, color: Colors.amber[100])
                  else if (category == "News and Current Affairs")
                    Icon(Icons.trending_up, color: Colors.amber[100])
                  else if (category == "Polls")
                    Icon(Icons.poll, color: Colors.amber[100])
                  else if (category == "Quiz")
                    Icon(Icons.lightbulb, color: Colors.amber[100])
                  else if (category == "Question Papers")
                    FaIcon(FontAwesomeIcons.question, color: Colors.amber[100])
                  else if (category == "Documents")
                    FaIcon(FontAwesomeIcons.solidFile, color: Colors.amber[100])
                  else if (category == "Thesis")
                    FaIcon(FontAwesomeIcons.solidNewspaper,
                        color: Colors.amber[100])
                  else if (category == "Images")
                    Icon(Icons.image, color: Colors.amber[100]),
                  SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    category,
                    style: style,
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Icon(Icons.arrow_forward,
                      size: 20.0, color: Color(0xFF3EC3C1))
                ],
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.grey[300], width: 5.0)))),
    );
  }

  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    InterstitialAd newAd = (!kIsWeb) ? ams.getInterstitialAd() : null;

    if (!kIsWeb) newAd.load();
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        child: Column(
          children: [
            Container(
              width: 700.0,
              height: deviceHeight * 2.1,
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
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      "Study Materials",
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Times',
                          fontSize: 25.0,
                          color: Colors.cyan[900],
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: deviceHeight / 50,
                  ),
                  categoryButton("Videos"),
                  SizedBox(
                    height: deviceHeight / 50,
                  ),
                  categoryButton("Images"),
                  SizedBox(
                    height: deviceHeight / 50,
                  ),
                  categoryButton("Question Papers"),
                  SizedBox(
                    height: deviceHeight / 50,
                  ),
                  categoryButton("Documents"),
                  SizedBox(
                    height: deviceHeight / 50,
                  ),
                  categoryButton("Thesis"),
                  SizedBox(
                    height: deviceHeight / 50,
                  ),
                  categoryButton("Study Materials"),
                  SizedBox(
                    height: deviceHeight / 50,
                  ),
                  categoryButton("News and Current Affairs"),
                  SizedBox(
                    height: deviceHeight / 50,
                  ),
                  categoryButton("Polls"),
                  SizedBox(
                    height: deviceHeight / 50,
                  ),
                  categoryButton("Quiz"),
                  SizedBox(
                    height: deviceHeight / 50,
                  ),
                  if (kIsWeb)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Download Our Application from PlayStore"),
                            GestureDetector(
                              onTap: () {},
                              child: Image(
                                image: AssetImage("Images/playstore.png"),
                                width: deviceWidth / 5,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Have any doubt? ask Admin or post "
                            "your question on our QNA Forum.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.orange, fontFamily: 'Times'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: deviceWidth,
              height: 100.0,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.cyan,
                      Colors.blue[900],
                      Colors.red,
                    ],
                  ),
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
                  border: Border.all(color: Colors.white)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Follow us on Social Media for daily Updates",
                    style: TextStyle(color: Colors.grey[300]),
                  ),
                  SizedBox(
                    height: deviceHeight / 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RaisedButton(
                          child: FaIcon(
                            FontAwesomeIcons.facebookF,
                            color: Colors.blue[600],
                          ),
                          color: Colors.grey[300],
                          onPressed: () {
                            _launchURL(
                                'https://www.facebook.com/Agriglance/?pageid=1587328474830432&ftentidentifier=2727538327476102&padding=0');
                          },
                          shape: CircleBorder()),
                      RaisedButton(
                          child: FaIcon(
                            FontAwesomeIcons.youtube,
                            color: Colors.red,
                          ),
                          color: Colors.grey[300],
                          onPressed: () {
                            _launchURL(
                                'https://www.youtube.com/channel/UCTdud6FaN4rYas1OnHO6JoQ');
                          },
                          shape: CircleBorder()),
                      RaisedButton(
                          child: FaIcon(
                            FontAwesomeIcons.linkedin,
                            color: Colors.blue[900],
                          ),
                          color: Colors.grey[300],
                          onPressed: () {
                            _launchURL(
                                'https://www.linkedin.com/in/agriglance-icar-6060ab9a/');
                          },
                          shape: CircleBorder()),
                    ],
                  ),
                ],
              ),
            ),
            if (kIsWeb)
              Text("Copyright © 2020 - Agriglance | All rights reserved")
          ],
        ),
      ),
    );
  }

  void _launchURL(url) async => await canLaunch(url)
      ? await launch(url)
      : Fluttertoast.showToast(msg: "Could not launch $url");
}
