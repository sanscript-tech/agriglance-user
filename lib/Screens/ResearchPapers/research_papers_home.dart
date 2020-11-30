import 'package:agriglance/Screens/ResearchPapers/add_research_paper.dart';
import 'package:agriglance/constants/research_paper_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResearchPapersHome extends StatefulWidget {
  @override
  _ResearchPapersHomeState createState() => _ResearchPapersHomeState();
}

class _ResearchPapersHomeState extends State<ResearchPapersHome> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Research Papers"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddResearchPaper(
                    uid: auth.currentUser.uid,
                    uName: auth.currentUser.displayName))),
        child: Icon(Icons.add),
      ),
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("research_papers")
              .snapshots(),
          builder: (context, snapshot) {
            return !snapshot.hasData
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot papers = snapshot.data.documents[index];
                      if (papers['isApprovedByAdmin']) {
                        return GestureDetector(
                          onTap: () {},
                          child: ResearchPaperCard(
                            title: papers['title'],
                            description: papers['description'],
                            pdfUrl: papers['pdfUrl'],
                            postedByName: papers['postedByName'],
                            index: index,
                          ),
                        );
                      }
                      return null;
                    },
                  );
          },
        ),
      ),
    );
  }
}
