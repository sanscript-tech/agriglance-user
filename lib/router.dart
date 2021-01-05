import 'package:agriglance/Screens/Home/Drawer/contactAdmin.dart';
import 'package:agriglance/Screens/Home/Drawer/my_documents.dart';
import 'package:agriglance/Screens/Home/Drawer/my_images.dart';
import 'package:agriglance/Screens/Home/Drawer/my_jobs.dart';
import 'package:agriglance/Screens/Home/Drawer/my_news_and_currentAffairs.dart';
import 'package:agriglance/Screens/Home/Drawer/my_points.dart';
import 'package:agriglance/Screens/Home/Drawer/my_poll.dart';
import 'package:agriglance/Screens/Home/Drawer/my_question_papers.dart';
import 'package:agriglance/Screens/Home/Drawer/my_questions.dart';
import 'package:agriglance/Screens/Home/Drawer/my_quiz.dart';
import 'package:agriglance/Screens/Home/Drawer/my_study_materials.dart';
import 'package:agriglance/Screens/Home/Drawer/my_thesis.dart';
import 'package:agriglance/Screens/Home/Drawer/my_videos.dart';
import 'package:agriglance/Screens/Home/Profile/profile.dart';
import 'package:agriglance/Screens/Home/Profile/update_profile.dart';
import 'package:agriglance/Services/authenticate.dart';
import 'package:agriglance/undefind_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:universal_html/prefer_universal/js.dart';
import 'Screens/Home/home.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  print(settings.name);
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(
          builder: (context) => (kIsWeb)
              ? Home()
              : ((FirebaseAuth.instance.currentUser == null)
                  ? Authenticate()
                  : Home()),
          settings: settings);
    case '/updateProfile':
      return MaterialPageRoute(
          builder: (context) => UpdateProfile(), settings: settings);
    case '/profile':
      return MaterialPageRoute(
          builder: (context) => Profile(), settings: settings);
    case '/myPoints':
      return MaterialPageRoute(
          builder: (context) => MyPoints(), settings: settings);
    case '/myStudyMaterials':
      return MaterialPageRoute(
          builder: (context) => MyStudyMaterials(), settings: settings);
    case '/myQuestionPaper':
      return MaterialPageRoute(
          builder: (context) => MyQuestionPapers(), settings: settings);
    case '/myDocuments':
      return MaterialPageRoute(
          builder: (context) => MyDocuments(), settings: settings);
    case '/myThesis':
      return MaterialPageRoute(
          builder: (context) => MyThesis(), settings: settings);
    case '/myJobs':
      return MaterialPageRoute(
          builder: (context) => MyJobs(), settings: settings);
    case '/myQuestions':
      return MaterialPageRoute(
          builder: (context) => MyQuestions(), settings: settings);
    case '/myNews&CurrentAffairs':
      return MaterialPageRoute(
          builder: (context) => MyNewsAndCurrentAffairs(), settings: settings);
    case '/myPolls':
      return MaterialPageRoute(
          builder: (context) => MyPoll(), settings: settings);
    case '/myQuiz':
      return MaterialPageRoute(
          builder: (context) => MyQuiz(), settings: settings);
    case '/myVideos':
      return MaterialPageRoute(
          builder: (context) => MyVideos(), settings: settings);
    case '/myImages':
      return MaterialPageRoute(
          builder: (context) => MyImages(), settings: settings);
    case '/contactAdmin':
      return MaterialPageRoute(
          builder: (context) => ContactAdmin(), settings: settings);
      break;
    default:
      return MaterialPageRoute(
          builder: (context) => UndefinedView(name: settings.name),
          settings: settings);
  }
}
