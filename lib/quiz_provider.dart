import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quizz_app/models/questionmakermodel.dart';
import 'package:quizz_app/models/settingsmodel.dart';

import 'dbhelper/db_helper.dart';
import 'temp_db.dart';

class QuizProvider extends ChangeNotifier {
  int duration = 10;
  String timeString = '';
  int ra = 0;
List<AddQuestionsModel> questionlist1=[];
List<AddQuestionsModel> Questionsbytitlelist=[];
List<AddQuestionsModel> TitleList=[];
List<SettingsModel> settingslist=[];
  Future<bool> addQuestion(AddQuestionsModel addQuestionsModel) async {
    final rowId = await DBHelper.insertquestion(addQuestionsModel);
    if(rowId > 0) {
      addQuestionsModel.id = rowId;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> addSettings(SettingsModel settingsModel) async {
    final rowId = await DBHelper.insertsettings(settingsModel);
    if(rowId > 0) {
      settingsModel.id = rowId;
      notifyListeners();
      return true;
    }
    return false;
  }

  getallQuestions() {
    DBHelper.getAllQuestions().then((value) {
      questionlist1 = value;
      notifyListeners();
    });
  }
  getallSettings() {
    DBHelper.getAllSettings().then((value) {
      settingslist = value;
      notifyListeners();
    });
  }

  getallQuestionsBytitle(String? title) {
    DBHelper.getAllQuestionsByTitle(title).then((value) {
      Questionsbytitlelist = value;
      notifyListeners();
    });
  }
  getallQuiztitle() {
    DBHelper.getAllQuizyTitle().then((value) {
      TitleList = value;
      notifyListeners();
    });
  }

  updateAns(int? id, String value){
    DBHelper.updateAns(id, value).then((_){
      notifyListeners();
    });
  }

  updatePrevEn(int? id, int value){
    DBHelper.updatePrevEn(id, value).then((_){
      notifyListeners();
    });
  }
  updateShowNasEn(int? id, int value){
    DBHelper.updateShowAnsEn(id, value).then((_){
      notifyListeners();
    });
  }
  updateTimeLimEn(int? id, int value){
    DBHelper.updateTimerEn(id, value).then((_){
      notifyListeners();
    });
  }

  final List<Map<String, dynamic>> questionList = [
    {
      question : 'Which of the following is not a built in type in Dart?',
      options : ['int', 'float', 'bool', 'Function'],
      rightAnswer : 'float',
      givenAnswer : ''
    },
    {
      question : 'Which one is false?',
      options : ['Abstract method doesn’t have a body', 'Abstract classes cannot be instantiated', 'A class can have multiple constructors', 'A class can’t implement another class and can be mixed with another class at the same time'],
      rightAnswer : 'A class can’t implement another class and can be mixed with another class at the same time',
      givenAnswer : ''
    },
    {
      question : 'True/False: Positional arguments cannot have a default value',
      options : ['True', 'False',],
      rightAnswer : 'True',
      givenAnswer : ''
    },
    {
      question : 'The _______ function is a predefined method in Dart',
      options : ['declare', 'list', 'main', 'return'],
      rightAnswer : 'main',
      givenAnswer : ''
    },
    {
      question : 'SDK stands for _____',
      options : [
        'System Dart Kernel',
        'Software Development Kernel',
        'Software Development Kit',
        'Software Design Key'],
      rightAnswer : 'Software Development Kit',
      givenAnswer : ''
    },
  ];

  updateDuration() {
    duration--;
  }




  setTime() {
    timeString = DateFormat('mm:ss').format(DateTime.fromMillisecondsSinceEpoch(duration * 1000));
    notifyListeners();
  }
}