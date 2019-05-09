import 'package:flutter/material.dart';
import 'package:recomendo/models/recommendation.dart';
import 'package:recomendo/utils/database_helper.dart';
import 'package:recomendo/utils/star_rating.dart';
import 'package:recomendo/utils/time_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';

class RecommendationDetail extends StatefulWidget {
  final String appBarTitle;
  final Recommendation recommendation;

  RecommendationDetail(this.recommendation, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return RecommendationDetailState(this.recommendation, appBarTitle);
  }
}

class RecommendationDetailState extends State<RecommendationDetail> {
  static var _categories = ["Restaurant", "Gelateria", "Unknown"];

  DatabaseHelper helper = DatabaseHelper();

  String appBarTitle;
  Recommendation recommendation;

  RecommendationDetailState(this.recommendation, this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return WillPopScope(
      onWillPop: () {
        moveToLastScreen();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                moveToLastScreen();
              }),
        ),
        body: Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[
                // Category drop down
                Row(children: <Widget>[
                  Expanded(child: Text("Category")),
                  Expanded(
                      child: DropdownButton(
                    items: _categories.map((String dropDownStringItem) {
                      return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      );
                    }).toList(),
                    value: getCategoryAsString(recommendation.category),
                    onChanged: (valueSelectedByUser) {
                      setState(() {
                        updateCategoryAsInt(valueSelectedByUser);
                      });
                    },
                  )),
                ]),

                // Title form field
                TextField(
                    onChanged: (value) => recommendation.title = value,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    )),

                Divider(),

                // Images: Image 1
                Center(child: Text("Images", style: textStyle)),
                Row(children: <Widget>[
                  Expanded(child: getImageWidget(recommendation.imageOne)),
                  Expanded(
                      child: RaisedButton(
                          onPressed: getImage, child: Text("Pick Photo 1")))
                ]),

                // Image 2
                Row(children: <Widget>[
                  Expanded(child: getImageWidget(recommendation.imageTwo)),
                  Expanded(
                      child: RaisedButton(
                          onPressed: getImage, child: Text("Pick Photo 2")))
                ]),

                // Image 3
                Row(children: <Widget>[
                  Expanded(child: getImageWidget(recommendation.imageThree)),
                  Expanded(
                      child: RaisedButton(
                          onPressed: getImage, child: Text("Pick Photo 3")))
                ]),

                // Comment form field
                TextField(
                    onChanged: (value) => recommendation.comment = value,
                    decoration: InputDecoration(labelText: 'Comment')),

                // Address form field
                TextField(
                    onChanged: (value) => recommendation.address = value,
                    decoration: InputDecoration(labelText: 'Address')),

                // Website form field
                TextField(
                  onChanged: (value) =>
                      recommendation.website = Uri.parse(value),
                  decoration: InputDecoration(labelText: 'Website'),
                  keyboardType: TextInputType.url,
                ),

                // Phone form field
                TextField(
                  onChanged: (value) => recommendation.phone = value,
                  decoration: InputDecoration(labelText: 'Phone'),
                  keyboardType: TextInputType.phone,
                ),
                Divider(),

                // Location
                Center(child: Text("Location", style: textStyle)),
                Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Row(children: <Widget>[
                      Expanded(
                          child: Text(
                              "Longitude: ${recommendation.longitude.toString()}")),
                      Expanded(
                          child: Text(
                              "Latitude: ${recommendation.longitude.toString()}")),
                    ])),

                // Rating
                Center(child: Text("Rating", style: textStyle)),
                Center(
                  child: StarRating(
                    value: recommendation.rating,
                    onChanged: (selectedValue) {
                      setState(() {
                        recommendation.rating = selectedValue;
                      });
                    },
                  ),
                ),

                // Notify me
                CheckboxListTile(
                  title: Text('Notify me'),
                  value: (recommendation.notifyMe == true) ? true : false,
                  onChanged: (bool value) {
                    setState(() {
                      recommendation.notifyMe = value;
                    });
                  },
                  secondary: Icon(Icons.notifications),
                ),

                Divider(),

                // Opening hours
                Center(child: Text("Opening hours", style: textStyle)),
                // Monday opening hours
                Row(children: <Widget>[
                  getTimePicker(recommendation.moFrom),
                  getTimePicker(recommendation.moTill),
                ]),

                // Tuesday opening hours
                Row(children: <Widget>[
                  getTimePicker(recommendation.tueFrom),
                  getTimePicker(recommendation.tueTill),
                ]),

                // Wednesday opening hours
                Row(children: <Widget>[
                  getTimePicker(recommendation.wedFrom),
                  getTimePicker(recommendation.wedTill),
                ]),

                // Thursday opening hours
                Row(children: <Widget>[
                  getTimePicker(recommendation.thurFrom),
                  getTimePicker(recommendation.thurTill),
                ]),

                // Friday opening hours
                Row(children: <Widget>[
                  getTimePicker(recommendation.friFrom),
                  getTimePicker(recommendation.friTill),
                ]),

                // Saturday opening hours
                Row(children: <Widget>[
                  getTimePicker(recommendation.satFrom),
                  getTimePicker(recommendation.satTill),
                ]),

                // Sunday opening hours
                Row(children: <Widget>[
                  getTimePicker(recommendation.sunFrom),
                  getTimePicker(recommendation.sunTill),
                ]),

                // Holiday opening hours
                Row(children: <Widget>[
                  getTimePicker(recommendation.holidayFrom),
                  getTimePicker(recommendation.holidayTill),
                ]),

                // Save and Delete
                Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            'Save',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() => _save());
                          },
                        )),
                        Container(
                          width: 5.0,
                        ),
                        Expanded(
                            child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            'Delete',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() => _delete());
                          },
                        )),
                      ],
                    )),
              ],
            )),
      ),
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void updateCategoryAsInt(String category) {
    switch (category) {
      case 'Restaurant':
        recommendation.category = 1;
        break;
      case 'Gelateria':
        recommendation.category = 2;
        break;
      default:
        recommendation.category = 3;
    }
  }

  String getCategoryAsString(int value) {
    switch (value) {
      case 1:
        return _categories[0];
        break;
      case 2:
        return _categories[1];
        break;
      default:
        return _categories[2];
    }
  }

  void _save() async {
    moveToLastScreen();
    recommendation.updatedAt = DateTime.now();

    int result;
    if (recommendation.id != null) {
      result = await helper.updateRecommendation(recommendation);
    } else {
      result = await helper.insertRecommendation(recommendation);
    }

    if (result != 0) {
      _showAlertDialog('Status', 'Recommendation saved successfully');
    } else {
      _showAlertDialog('Status', 'Error updating recommendation');
    }
  }

  void _delete() async {
    moveToLastScreen();

    if (recommendation.id == null) {
      _showAlertDialog('Status', 'Creation of new recommendation aborted');
      return;
    }

    int result = await helper.deleteRecommendation(recommendation.id);
    if (result != 0) {
      _showAlertDialog('Status', 'Recommendation deleted successfully');
    } else {
      _showAlertDialog('Status', 'Error occured deleting recommendation');
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      recommendation.imageOne = image.path;
    });
  }

  Widget getImageWidget(path) {
    if (path != null) {
      debugPrint(path);
      return Image(
        image: FileImage(File(path)),
        width: 150.0,
        height: 100.0,
      );
    } else {
      return IconButton(icon: Icon(Icons.image), iconSize: 50);
    }
  }
}
