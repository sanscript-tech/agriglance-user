import 'package:agriglance/Screens/Documents/documents_home.dart';
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
import 'package:agriglance/Screens/Images/images_home.dart';
import 'package:agriglance/Screens/News/news_home.dart';
import 'package:agriglance/Screens/Polls/poll_home.dart';
import 'package:agriglance/Screens/QuestionPaper/question_papers_home.dart';
import 'package:agriglance/Screens/Quiz/quiz_home.dart';
import 'package:agriglance/Screens/StudyMaterials/study_materials__home.dart';
import 'package:agriglance/Screens/Thesis/thesis_home.dart';
import 'package:agriglance/Screens/Videos/video_home.dart';
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
          case '/studyMaterials':
          return MaterialPageRoute(
          builder: (context) => StudyMaterialsHome(), settings: settings);
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
    case '/login':
      return MaterialPageRoute(
          builder: (context) => Authenticate(), settings: settings);
    case '/materials/studyMaterials':
      return MaterialPageRoute(
          builder: (context) => StudyMaterialsHome(), settings: settings);
    case '/materials/videos':
      return MaterialPageRoute(
          builder: (context) => VideoHome(), settings: settings);
    case '/materials/news&CurrentAffairs':
      return MaterialPageRoute(
          builder: (context) => NewsHome(), settings: settings);
    case '/materials/polls':
      return MaterialPageRoute(
          builder: (context) => PollHome(), settings: settings);
          case '/materials/quiz':
      return MaterialPageRoute(
          builder: (context) => QuizHome(), settings: settings);
          case '/materials/images':
      return MaterialPageRoute(
          builder: (context) => ImageHome(), settings: settings);
          case '/materials/questionPapers':
      return MaterialPageRoute(
          builder: (context) => QuestionPapersHome(), settings: settings);
          case '/materials/documents':
      return MaterialPageRoute(
          builder: (context) =>DocumentsHome(), settings: settings);
          case '/materials/thesis':
      return MaterialPageRoute(
          builder: (context) => ThesisHome(), settings: settings);
    default:
      return MaterialPageRoute(
          builder: (context) => UndefinedView(name: settings.name),
          settings: settings);
  }
}
