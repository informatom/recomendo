import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:recomendo/models/recommendation.dart';


class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  String recommendationTable = 'recommendation_table';
  String colId = 'id';
  String colAddress = 'address';
  String colAudioComment = 'audioComment';
  String colTitle = 'title';
  String colCategory = 'category';
  String colComment = 'comment';
  String colImageOne = 'imageOne';
  String colImageTwo = 'imageTwo';
  String colImageThree = 'imageThree';
  String colInsertedAt = 'insertedAt';
  String colLatitude = 'latitude';
  String colLongitude = 'longitude';
  String colNotifyMe = 'notifyMe';
  String colPhone = 'phone';
  String colRating = 'rating';
  String colUpdatedAt = 'updatedAt';
  String colWebsite = 'website';
  String colMoFrom = 'moFrom';
  String colTueFrom = 'tueFrom';
  String colWedFrom = 'wedFrom';
  String colThurFrom = 'thurFrom';
  String colFriFrom = 'friFrom';
  String colSatFrom = 'satFrom';
  String colSunFrom = 'sunFrom';
  String colHolidayFrom = 'holidayFrom';
  String colMoTill = 'moTill';
  String colTueTill = 'tueTill';
  String colWedTill = 'wedTill';
  String colThurTill = 'thurTill';
  String colFriTill = 'friTill';
  String colSatTill = 'satTill';
  String colSunTill = 'sunTill';
  String colHolidayTill = 'holidayTill';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if(_databaseHelper == null ) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'recomendo.db';

    var recomendoDatabase = await openDatabase(
        path,
        version: 1,
        onCreate: _createDb
    );
    return recomendoDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
      "CREATE TABLE $recommendationTable($colId INTEGER PRIMARY KEY AUTOINCREMENT,"
      "$colAddress TEXT, "
      "$colAudioComment TEXT, "
      "$colTitle TEXT, "
      "$colCategory, "
      "$colComment TEXT, "
      "$colImageOne TEXT, "
      "$colImageTwo TEXT,  "
      "$colImageThree TEXT, "
      "$colInsertedAt TEXT, "
      "$colLatitude REAL, "
      "$colLongitude REAL, "
      "$colNotifyMe STRING, "
      "$colPhone TEXT, "
      "$colRating INTEGER, "
      "$colUpdatedAt TEXT, "
      "$colWebsite TEXT, "
      "$colMoFrom TEXT, "
      "$colTueFrom TEXT, "
      "$colWedFrom TEXT, "
      "$colThurFrom TEXT, "
      "$colFriFrom TEXT, "
      "$colSatFrom TEXT, "
      "$colSunFrom TEXT, "
      "$colHolidayFrom TEXT, "
      "$colMoTill TEXT, "
      "$colTueTill TEXT, "
      "$colWedTill TEXT, "
      "$colThurTill TEXT, "
      "$colFriTill TEXT, "
      "$colSatTill TEXT, "
      "$colSunTill TEXT, "
      "$colHolidayTill TEXT) "
    );
  }

  Future<List<Map<String, dynamic>>> getRecommendationMapList() async {
    Database db = await this.database;

    var result = await db.query(
        recommendationTable,
        orderBy: '$colUpdatedAt DESC'
    );
    return result;
  }

  Future<int> insertRecommendation(Recommendation recommendation) async {
    Database db = await this.database;

    var result = await db.insert(
        recommendationTable,
        recommendation.toMap()
    );
    return result;
  }

  Future<int> updateRecommendation(Recommendation recommendation) async {
    var db = await this.database;
    var result = await db.update(
      recommendationTable,
      recommendation.toMap(),
      where: '$colId = ?',
      whereArgs: [recommendation.id]
    );
    return result;
  }

  Future<int> deleteRecommendation(int id) async {
    var db = await this.database;
    int result = await db.delete(
        recommendationTable,
        where: '$colId =?',
        whereArgs: [id]);
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery(
        'SELECT COUNT(*) from $recommendationTable'
    );
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Recommendation>> getRecommendationList() async {
    var recommendationMapList = await getRecommendationMapList();
    int count = recommendationMapList.length;

    List<Recommendation> recommendationList = List<Recommendation>();
    for (int i = 0; i < count; i++) {
      recommendationList.add(Recommendation.fromMapObject(recommendationMapList[i]));
    }

    return recommendationList;
  }
}
