import 'package:path/path.dart';
import 'package:quizz_app/models/questionmakermodel.dart';
import 'package:quizz_app/models/settingsmodel.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper{
  static const String createTableQuestions='''create table $tablequestion(
  $tablequestionid integer primary key autoincrement,
  $tablequestionname text,
  $tablequestionopone text,
  $tablequestionoptwo text,
  $tablequestionopthree text,
  $tablequestionopfour text,
  $tablequestionrightans text,
  $tablequestiongivenans text,
  $tablequestionquiztitle text
  )''';

  static const String createTableSettings='''create table $tablesettings(
  $tablequestionid integer primary key autoincrement,
  $tablesettingsprevswitch integer,
  $tablesettingsshowansswitch integer,
  $tablesettingstimelimitedwitch integer
  )''';

  static Future<Database> open() async{
    final rootPath =await getDatabasesPath();
    final dbPath =join(rootPath,'questions.db');
    return openDatabase(dbPath, version: 1, onCreate: (db,version) async{
      await db.execute(createTableQuestions);
      await db.execute(createTableSettings);
    });
  }
  static Future<int> insertquestion(AddQuestionsModel addQuestionsModel) async{
    final db = await open();
    return db.insert(tablequestion, addQuestionsModel.toMap());
  }
  static Future<int> insertsettings(SettingsModel settingsModel) async{
    final db = await open();
    return db.insert(tablesettings, settingsModel.toMap());
  }

  static Future<List<AddQuestionsModel>> getAllQuestions() async {
    final db = await open();
    final List<Map<String, dynamic>> mapList = await db.query(tablequestion);
    return List.generate(mapList.length, (index) => AddQuestionsModel.fromMap(mapList[index]));
  }

  static Future<List<SettingsModel>> getAllSettings() async {
    final db = await open();
    final List<Map<String, dynamic>> mapList = await db.query(tablesettings);
    return List.generate(mapList.length, (index) => SettingsModel.fromMap(mapList[index]));
  }

  static Future<List<AddQuestionsModel>> getAllQuestionsByTitle(String? qtitle) async {
    final db = await open();
    final List<Map<String, dynamic>> mapList = await db.rawQuery('SELECT * FROM $tablequestion WHERE $tablequestionquiztitle=?', [qtitle]);
    return List.generate(mapList.length, (index) => AddQuestionsModel.fromMap(mapList[index]));
  }

  static Future<List<AddQuestionsModel>> getAllQuizyTitle() async {
    final db = await open();
    final List<Map<String, dynamic>> mapList = await db.rawQuery('SELECT DISTINCT * FROM $tablequestion');
    return List.generate(mapList.length, (index) => AddQuestionsModel.fromMap(mapList[index]));
  }

  static Future<int> updateAns(int? id, String value) async {
    final db = await open();
    return db.update(tablequestion, {tablequestiongivenans: value}, where: '$tablequestionid = ?', whereArgs: [id]);

  }

  static Future<int> updatePrevEn(int? id, int value) async {
    final db = await open();
    return db.update(tablesettings, {tablesettingsprevswitch: value}, where: '$tablesettingsid = ?', whereArgs: [id]);

  }
  static Future<int> updateShowAnsEn(int? id, int value) async {
    final db = await open();
    return db.update(tablesettings, {tablesettingsshowansswitch: value}, where: '$tablesettingsid = ?', whereArgs: [id]);

  }

  static Future<int> updateTimerEn(int? id, int value) async {
    final db = await open();
    return db.update(tablesettings, {tablesettingstimelimitedwitch: value}, where: '$tablesettingsid = ?', whereArgs: [id]);

  }
}