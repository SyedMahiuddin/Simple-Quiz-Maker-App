import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizz_app/pages/instantquiz_page.dart';
import 'package:quizz_app/pages/question_page.dart';
import 'package:quizz_app/pages/quizlistpage.dart';
import 'package:quizz_app/pages/quizmaker_page.dart';
import 'package:quizz_app/pages/result_page.dart';
import 'package:quizz_app/pages/resultshowingpage.dart';
import 'package:quizz_app/pages/settins_page.dart';
import 'package:quizz_app/pages/splashscreen.dart';
import 'package:quizz_app/pages/viewquestion.dart';
import 'package:quizz_app/quiz_provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => QuizProvider()..getallQuestions()..getallQuiztitle()..getallSettings()),
  ],
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: SplashPage.routeName,
      routes: {
        SplashPage.routeName:(context)=>SplashPage(),
        QuestionPage.routeName : (context) => QuestionPage(),
        ViewQuestionPage.routeName:(context)=> ViewQuestionPage(),
        QuizMakerPage.routeName:(context)=> QuizMakerPage(),
        ResultShowingPage.routeName:(context)=> ResultShowingPage(),
        InstantQuizPage.routeName:(context)=> InstantQuizPage(),
        QuizListPage.routeName:(context)=>QuizListPage(),
        SettingsPage.routeName:(context)=> SettingsPage()
      },
    );
  }
}

