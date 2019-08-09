import 'package:flutter/material.dart';
import 'package:recomendo/models/recommendation.dart';
import 'package:recomendo/utils/star_rating.dart';
import 'package:recomendo/screens/recommendation_detail.dart';
import 'package:recomendo/utils/database_helper.dart';

class MainData extends StatelessWidget {
  final Recommendation recommendation;
  final RecommendationDetailState parentWidget;
  final DatabaseHelper helper;
  final List<String> categories = ["Restaurant", "Gelateria", "Unknown"];

  MainData({this.recommendation, this.parentWidget, this.helper});

  @override
  Widget build(BuildContext context) {

    return Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            // Category drop down
            Row(children: <Widget>[
              Expanded(child: Text("Category")),
              Expanded(
                  child: DropdownButton(
                items: categories.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
                }).toList(),
                value: getCategoryAsString(recommendation.category),
                onChanged: (valueSelectedByUser) {
                  parentWidget.setState(() {
                    updateCategoryAsInt(valueSelectedByUser);
                  });
                },
              )),
            ]),

            // Title form field
            TextField(
                onChanged: (value) => recommendation.title = value,
                decoration: InputDecoration(labelText: 'Title')),

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
              onChanged: (value) => recommendation.website = Uri.parse(value),
              decoration: InputDecoration(labelText: 'Website'),
              keyboardType: TextInputType.url,
            ),

            // Phone form field
            TextField(
              onChanged: (value) => recommendation.phone = value,
              decoration: InputDecoration(labelText: 'Phone'),
              keyboardType: TextInputType.phone,
            ),

            Divider( height: 50),
            // Rating
            Row(
              children: <Widget>[
                Expanded(
                  child: Text("Rating"),
                ),
                Expanded(
                  child: StarRating(
                    value: recommendation.rating,
                    onChanged: (selectedValue) {
                      parentWidget.setState(() {
                        recommendation.rating = selectedValue;
                      });
                    },
                  ),
                ),
              ],
            ),
            Divider(),

            // Notify me
            CheckboxListTile(
              title: Text('Notify me'),
              value: (recommendation.notifyMe == true) ? true : false,
              onChanged: (bool value) {
                parentWidget.setState(() {
                  recommendation.notifyMe = value;
                });
              },
              secondary: Icon(Icons.notifications),
            ),

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
                        parentWidget.setState(() => _save(context));
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
                        parentWidget.setState(() => _delete(context));
                      },
                    )),
                  ],
                )),
          ],
        ));
  }

  String getCategoryAsString(int value) {
    switch (value) {
      case 1:
        return categories[0];
        break;
      case 2:
        return categories[1];
        break;
      default:
        return categories[2];
    }
  }

  void _save(BuildContext context) async {
    parentWidget.moveToLastScreen();
    recommendation.updatedAt = DateTime.now();

    int result;
    if (recommendation.id != null) {
      result = await helper.updateRecommendation(recommendation);
    } else {
      result = await helper.insertRecommendation(recommendation);
    }

    if (result != 0) {
      if (recommendation.longitude == null) {
        _showAlertDialog(context, 'Status', 'Recommendation saved successfully,'
                                            ' but no coordinates could be derived');
      } else {
        _showAlertDialog(context, 'Status', 'Recommendation saved successfully');
      }
    } else {
      _showAlertDialog(context, 'Status', 'Error updating recommendation');
    }
  }

  void _delete(BuildContext context) async {
    parentWidget.moveToLastScreen();

    if (recommendation.id == null) {
      _showAlertDialog(context, 'Status', 'Creation of new recommendation aborted');
      return;
    }

    int result = await helper.deleteRecommendation(recommendation.id);
    if (result != 0) {
      _showAlertDialog(context, 'Status', 'Recommendation deleted successfully');
    } else {
      _showAlertDialog(context, 'Status', 'Error occured deleting recommendation');
    }
  }

  void _showAlertDialog(BuildContext context, String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
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
}
