import 'package:agriglance/Screens/ResearchPapers/research_papers_home.dart';
import 'package:flutter/material.dart';

class MaterialsHome extends StatelessWidget {
  @override
  Widget categoryButton(String category, BuildContext context) {
    return RaisedButton(
      onPressed: () {
        switch (category) {
          case "Research Papers":
            {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ResearchPapersHome()));
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
              categoryButton("Research Papers", context),
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
              categoryButton("Current Affairs", context),
              SizedBox(
                width: deviceWidth / 7,
              ),
              categoryButton("News", context),
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
              categoryButton("Notes", context),
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
