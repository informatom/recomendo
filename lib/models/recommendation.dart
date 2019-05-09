import 'package:flutter/material.dart';

class Recommendation {
  int _id;
  String _address;
  String _audioComment;     // todo
  String _title;
  int _category;
  String _comment;
  String _imageOne;         // todo
  String _imageTwo;         // todo
  String _imageThree;       // todo
  DateTime _insertedAt;
  double _latitude;         // todo move logic
  double _longitude;        // todo move logic
  bool _notifyMe;           // todo
  String _phone;
  int _rating;              // todo
  DateTime _updatedAt;
  Uri _website;
  TimeOfDay _moFrom;
  TimeOfDay _tueFrom;
  TimeOfDay _wedFrom;
  TimeOfDay _thurFrom;
  TimeOfDay _friFrom;
  TimeOfDay _satFrom;
  TimeOfDay _sunFrom;
  TimeOfDay _holidayFrom;
  TimeOfDay _moTill;
  TimeOfDay _tueTill;
  TimeOfDay _wedTill;
  TimeOfDay _thurTill;
  TimeOfDay _friTill;
  TimeOfDay _satTill;
  TimeOfDay _sunTill;
  TimeOfDay _holidayTill;

  Recommendation(
      this._category,
      this._insertedAt,
      this._rating,
      this._title,
      this._updatedAt,
     [this._longitude,
      this._latitude,
      this._address,
      this._audioComment,
      this._comment,
      this._imageOne,
      this._imageTwo,
      this._imageThree,
      this._notifyMe,
      this._phone,
      this._website,
      this._moFrom,
      this._tueFrom,
      this._wedFrom,
      this._thurFrom,
      this._friFrom,
      this._satFrom,
      this._sunFrom,
      this._holidayFrom,
      this._moTill,
      this._tueTill,
      this._wedTill,
      this._thurTill,
      this._friTill,
      this._satTill,
      this._sunTill,
      this._holidayTill]);

  Recommendation.withId(this._id, this._category, this._insertedAt,
      this._rating, this._title, this._updatedAt,
      [this._address,
      this._audioComment,
      this._comment,
      this._imageOne,
      this._imageTwo,
      this._imageThree,
      this._latitude,
      this._longitude,
      this._notifyMe,
      this._phone,
      this._website,
      this._moFrom,
      this._tueFrom,
      this._wedFrom,
      this._thurFrom,
      this._friFrom,
      this._satFrom,
      this._sunFrom,
      this._holidayFrom,
      this._moTill,
      this._tueTill,
      this._wedTill,
      this._thurTill,
      this._friTill,
      this._satTill,
      this._sunTill,
      this._holidayTill]);

  int get id => _id;
  String get address => _address;
  String get audioComment => _audioComment;
  int get category => _category;
  String get comment => _comment;
  String get imageOne => _imageOne;
  String get imageTwo => _imageTwo;
  String get imageThree => _imageThree;
  DateTime get insertedAt => _insertedAt;
  double get latitude => _latitude;
  double get longitude => _longitude;
  String get phone => _phone;
  int get rating => _rating;
  String get title => _title;
  DateTime get updatedAt => _updatedAt;
  Uri get website => _website;
  TimeOfDay get moFrom => _moFrom;
  TimeOfDay get tueFrom => _tueFrom;
  TimeOfDay get wedFrom => _wedFrom;
  TimeOfDay get thurFrom => _thurFrom;
  TimeOfDay get friFrom => _friFrom;
  TimeOfDay get satFrom => _satFrom;
  TimeOfDay get sunFrom => _sunFrom;
  TimeOfDay get holidayFrom => _holidayFrom;
  TimeOfDay get moTill => _moTill;
  TimeOfDay get tueTill => _tueTill;
  TimeOfDay get wedTill => _wedTill;
  TimeOfDay get thurTill => _thurTill;
  TimeOfDay get friTill => _friTill;
  TimeOfDay get satTill => _satTill;
  TimeOfDay get sunTill => _sunTill;
  TimeOfDay get holidayTill => _holidayTill;
  bool get notifyMe => _notifyMe;

  set address(String newAddress) => this._address = newAddress;
  set audioComment(String newAudioComment) =>
      this._audioComment = newAudioComment;
  set category(int newCategory) => this._category = newCategory;
  set comment(String newComment) => this._comment = newComment;
  set imageOne(String newImageOne) => this._imageOne = newImageOne;
  set imageTwo(String newImageTwo) => this._imageTwo = newImageTwo;
  set imageThree(String newImageThree) => this._imageThree = newImageThree;
  set insertedAt(DateTime newInsertedAt) => this._insertedAt = newInsertedAt;
  set latitude(double newLatitude) => this._latitude = newLatitude;
  set longitude(double newLongitude) => this._longitude = newLongitude;
  set notifyMe(bool newNotifyMe) => this._notifyMe = newNotifyMe;
  set phone(String newPhone) => this.phone = newPhone;
  set rating(int newRating) => this._rating = newRating;
  set title(String newTitle) => this._title = newTitle;
  set updatedAt(DateTime newUpdatedAt) => this._updatedAt = newUpdatedAt;
  set website(Uri newWebsite) => this._website = newWebsite;
  set moFrom(TimeOfDay newMoFrom) => this._moFrom = newMoFrom;
  set tueFrom(TimeOfDay newTueFrom) => this._tueFrom = newTueFrom;
  set wedFrom(TimeOfDay newWedFrom) => this._wedFrom = newWedFrom;
  set thurFrom(TimeOfDay newThurFrom) => this._thurFrom = newThurFrom;
  set friFrom(TimeOfDay newFriFrom) => this._friFrom = newFriFrom;
  set satFrom(TimeOfDay newSatFrom) => this._satFrom = newSatFrom;
  set sunFrom(TimeOfDay newSunFrom) => this._sunFrom = newSunFrom;
  set holidayFrom(TimeOfDay newHolidayFrom) =>
      this._holidayFrom = newHolidayFrom;
  set moTill(TimeOfDay newMoTill) => this._moTill = newMoTill;
  set tueTill(TimeOfDay newTueTill) => this._tueTill = newTueTill;
  set wedTill(TimeOfDay newWedTill) => this._wedTill = newWedTill;
  set thurTill(TimeOfDay newThurTill) => this._thurTill = newThurTill;
  set friTill(TimeOfDay newFriTill) => this._friTill = newFriTill;
  set satTill(TimeOfDay newSatTill) => this._satTill = newSatTill;
  set sunTill(TimeOfDay newSunTill) => this._sunTill = newSunTill;
  set holidayTill(TimeOfDay newHolidayTill) =>
      this._holidayTill = newHolidayTill;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['address'] = _address;
    map['comment'] = _comment;
    map['audioComment'] = _audioComment;
    map['website'] = _website.toString();
    map['phone'] = _phone;
    map['imageOne'] = _imageOne;
    map['imageTwo'] = _imageTwo;
    map['imageThree'] = _imageThree;
    map['rating'] = _rating;
    map['category'] = _category;
    map['insertedAt'] = _insertedAt.toIso8601String();
    map['updatedAt'] = _updatedAt.toIso8601String();
    map['longitude'] = _longitude;
    map['latitude'] = _latitude;
    map['moFrom'] = _moFrom.toString();
    map['tueFrom'] = _tueFrom.toString();
    map['wedFrom'] = _wedFrom.toString();
    map['thurFrom'] = _thurFrom.toString();
    map['friFrom'] = _friFrom.toString();
    map['satFrom'] = _satFrom.toString();
    map['sunFrom'] = _sunFrom.toString();
    map['holidayFrom'] = _holidayFrom.toString();
    map['moTill'] = _moTill.toString();
    map['tueTill'] = _tueTill.toString();
    map['wedTill'] = _wedTill.toString();
    map['thurTill'] = _thurTill.toString();
    map['friTill'] = _friTill.toString();
    map['satTill'] = _satTill.toString();
    map['sunTill'] = _sunTill.toString();
    map['holidayTill'] = _holidayTill.toString();
    map['notifyMe'] = (_notifyMe == null) ? 1 : 0;

    return map;
  }

  Recommendation.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._address = map['address'];
    this._comment = map['comment'];
    this._audioComment = map['audioComment'];
    this._website = Uri.parse(map['website']);
    this._phone = map['phone'];
    this._imageOne = map['imageOne'];
    this._imageTwo = map['imageTwo'];
    this._imageThree = map['imageThree'];
    this._notifyMe = map['notifyMe'] == 1 ? true : false;
    this._rating = map['rating'];
    this._category = map['category'];
    this._insertedAt = DateTime.parse(map['insertedAt']);
    this._updatedAt = DateTime.parse(map['updatedAt']);
    this._longitude = map['longitude'];
    this._latitude = map['latitude'];
    this._moFrom = TimeOfDay(
        hour: getHour(map['moFrom']),
        minute: getMinute(map['moFrom'])
    );
    this._tueFrom = TimeOfDay(
        hour: getHour(map['tueFrom']),
        minute: getMinute(map['tueFrom'])
    );
    this._wedFrom = TimeOfDay(
        hour: getHour(map['wedFrom']),
        minute: getMinute(map['wedFrom'])
    );
    this._thurFrom = TimeOfDay(
        hour: getHour(map['thurFrom']),
        minute: getMinute(map['thurFrom'])
    );
    this._friFrom = TimeOfDay(
        hour: getHour(map['friFrom']),
        minute: getMinute(map['friFrom'])
    );
    this._satFrom = TimeOfDay(
        hour: getHour(map['satFrom']),
        minute: getMinute(map['satFrom'])
    );
    this._sunFrom = TimeOfDay(
        hour: getHour(map['sunFrom']),
        minute: getMinute(map['sunFrom'])
    );
    this._holidayFrom = TimeOfDay(
        hour: getHour(map['holidayFrom']),
        minute: getMinute(map['holidayFrom'])
    );
    this._moTill = TimeOfDay(
        hour: getHour(map['moTill']),
        minute: getMinute(map['moTill'])
    );
    this._tueTill = TimeOfDay(
        hour: getHour(map['tueTill']),
        minute: getMinute(map['tueTill'])
    );
    this._wedTill = TimeOfDay(
        hour: getHour(map['wedTill']),
        minute: getMinute(map['wedTill'])
    );
    this._thurTill = TimeOfDay(
        hour: getHour(map['thurTill']),
        minute: getMinute(map['thurTill'])
    );
    this._friTill = TimeOfDay(
        hour: getHour(map['friTill']),
        minute: getMinute(map['friTill'])
    );
    this._satTill = TimeOfDay(
        hour: getHour(map['satTill']),
        minute: getMinute(map['satTill'])
    );
    this._sunTill = TimeOfDay(
        hour: getHour(map['sunTill']),
        minute: getMinute(map['sunTill'])
    );
    this._holidayTill = TimeOfDay(
        hour: getHour(map['holidayTill']),
        minute: getMinute(map['holidayTill']));
  }

  int getHour(value) {
    if (value == 'null') {
      return 0;
    } else {
      int hour = int.parse(value.substring(10, 12));
      return hour;
    }
  }

  int getMinute(value) {
    if (value == 'null') {
      return 0;
    } else {
      int hour = int.parse(value.substring(13, 15));
      return hour;
    }
  }
}
