import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:provisional_license_test/questions/answer.dart';
import 'package:provisional_license_test/questions/question.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

String questionsTable = "question";
String columnId = "id";
String columnImage = "image";
String columnTitle = "title";
String columnCorrectAnswer = "correctAnswer";
String columnCategoryId = "categoryId";

String answersTable = "answer";
String columnOption = "option";
String columnQuestionId = "questionId";

String categoriesTable = "category";

class DBHelper{

  static Database _db;

  Future<Database> get db async{
    if(_db != null)
      return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "questions.db");

    var exists = await databaseExists(path);
    if (!exists) {
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "questions.db"));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);

    } else {
      print("Opening existing database");
    }
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    print("Opened");
    return theDb;
  }

  void _onCreate(Database db, int version) async {

  }

  Future<List<Question>> _getRandomQuestions() async{
      final client = http.Client();
      final response = await client.get('https://api.mockaroo.com/api/b2ed6a80?count=25&key=b2a53bb0');
      final questionsJson = json.decode(response.body);
      print(questionsJson);
//      questionsJson.map((q) => q.cast<Map<String, dynamic>>);
      final questionsJsonMap = questionsJson.map<Question>((json) => Question.fromJson(json)).toList();
      return questionsJsonMap;
  }

  Future<List<Question>> getRandomQuestions() async{
    final _questionIds = [1, 2, 3];
    List<Map> _questions = await _db.rawQuery(""
        "SELECT * "
        "FROM '$questionsTable"
        "WHERE '$columnQuestionId' IN ($_questionIds)");
    var _questionsList = _questions.map((_q) => Question.fromMap(_q));
    final List<Map> _options = await _db.rawQuery(""
        "SELECT *"
        "FROM '$answersTable'"
        "WHERE '$columnQuestionId' IN ($_questionIds)");
    final _optionsList = _options.map((_a)=> Option.fromMap(_a));
  }

  updateData() async{

  }

  Future saveTest() async{}
}