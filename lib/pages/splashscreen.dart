import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizz_app/pages/quizmaker_page.dart';

class SplashPage extends StatefulWidget {
  static const String routeName = '/';
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    _navigatesplash();
    super.initState();
  }
  void _navigatesplash ()async {
       await Future.delayed(Duration(milliseconds: 2200),(){});
       Navigator.pushNamed(context, QuizMakerPage.routeName);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: AnimatedSplashScreen(
            splash: 'assets/images/quiz.png',
            nextScreen: QuizMakerPage(),
            splashTransition: SplashTransition.rotationTransition,
          )
        ),
      ),
    );
  }
}

