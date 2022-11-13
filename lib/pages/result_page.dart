import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizz_app/pages/question_page.dart';
import 'package:quizz_app/quiz_provider.dart';
import 'package:quizz_app/temp_db.dart';

class ResultPage extends StatelessWidget {
  static const String routeName = '/result';
  int rightAnswers = 0;
  ResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('RESULT'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Correct Answers'),
            Consumer<QuizProvider>(
                builder: (context, provider, _) => Text('${provider.ra}', style: TextStyle(fontSize: 30),)),
            TextButton(
              onPressed: () => Navigator.pushReplacementNamed(context, QuestionPage.routeName),
              child: const Text('GO BACK'),
            )
          ],
        ),
      ),
    );
  }

}
