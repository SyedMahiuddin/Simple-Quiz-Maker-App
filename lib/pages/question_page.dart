import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quizz_app/customwidgets/question_set_widget.dart';
import 'package:quizz_app/pages/result_page.dart';
import 'package:quizz_app/quiz_provider.dart';
import 'package:quizz_app/temp_db.dart';

class QuestionPage extends StatefulWidget {
  static const String routeName = '/questionpage';
  const QuestionPage({Key? key}) : super(key: key);

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  //int duration = 10;
  bool hasQuizStarted = false;
  //String timeString = '';
  late Timer timer;
  late QuizProvider provider;
  @override
  void didChangeDependencies() {
    provider = Provider.of<QuizProvider>(context, listen: false);
    provider.setTime();
    super.didChangeDependencies();
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if(provider.duration == 0) {
        timer.cancel();
        Navigator.pushReplacementNamed(context, ResultPage.routeName);
      } else {
        setState(() {
          provider.updateDuration();
          provider.setTime();
        });
      }
    });
  }

  /*setTime() {
    timeString = DateFormat('mm:ss').format(DateTime.fromMillisecondsSinceEpoch(duration * 1000));
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Quiz'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pushNamed(context, ResultPage.routeName),
            child: const Text('FINISH', style: TextStyle(color: Colors.white),),
          )
        ],
      ),
      body: Column(
        children: [
          Text(provider.timeString, style: TextStyle(fontSize: 40),),
          if(!hasQuizStarted) ElevatedButton(
            onPressed: () {
              setState(() {
                hasQuizStarted = true;
              });
              startTimer();
            },
            child: const Text('START QUIZ'),
          ),
          if(hasQuizStarted) Expanded(
            child: Consumer<QuizProvider>(
              builder: (context, provider, _) => ListView.builder(
                itemCount: provider.questionList.length,
                itemBuilder: (context, index) {
                  final ques = provider.questionList[index];
                  return QuestionSetView(
                    map: ques,
                    index: index,
                    onAnswered: (value) {
                     // provider.submitAnswer(value, index);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
