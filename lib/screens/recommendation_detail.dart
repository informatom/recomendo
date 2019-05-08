import 'package:flutter/material.dart';
import 'package:recomendo/models/recommendation.dart';
import 'package:recomendo/utils/database_helper.dart';

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
  static var _categories = [
    "Restaurant",
    "Gelateria",
    "Unknown"
  ];

  DatabaseHelper helper = DatabaseHelper();

  String appBarTitle;
  Recommendation recommendation;

  TextEditingController titleController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  RecommendationDetailState(this.recommendation, this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    titleController.text = recommendation.title;
    commentController.text = recommendation.comment;

    return WillPopScope(
      onWillPop: () {
        moveToLastScreen();
      },

      child: Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
          leading: IconButton(
            icon: Icon(
                Icons.arrow_back),
                onPressed: () {
                  moveToLastScreen();
            }
          ),
        ),

        body: Padding(
          padding: EdgeInsets.only(
            top: 15.0,
            left: 10.0,
            right: 10.0),
          child: ListView(
            children: <Widget>[
              // Category drop down
              ListTile(
                title: DropdownButton(
                    items: _categories.map((String dropDownStringItem) {
                      return DropdownMenuItem<String> (
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      );
                    }).toList(),
                    style: textStyle,
                    value: getCategoryAsString(recommendation.category),
                    onChanged: (valueSelectedByUser) {
                      setState(() {
                        debugPrint('User selected $valueSelectedByUser');
                        updateCategoryAsInt(valueSelectedByUser);
                      });
                    },
                ),
              ),

              // Title form field
              Padding(
                padding: EdgeInsets.only(
                  top: 15.0,
                  bottom: 15.0
                ),
                child: TextField(
                  controller: titleController,
                  style: textStyle,
                  onChanged: (value) => updateTitle(),
                  decoration: InputDecoration(
                    labelText: 'Title',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)
                    )
                  ),
                ),
              ),

              // Comment form field
              Padding(
                padding: EdgeInsets.only(
                    top: 15.0,
                    bottom: 15.0
                ),
                child: TextField(
                  controller: commentController,
                  style: textStyle,
                  onChanged: (value) => updateComment(),
                  decoration: InputDecoration(
                      labelText: 'Comment',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      )
                  ),
                ),
              ),

              Text(recommendation.latitude.toString()),
              Text(recommendation.longitude.toString()),

              // Save and Delete
              Padding(
                padding: EdgeInsets.only(
                    top: 15.0,
                    bottom: 15.0
                ),
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
                      )
                    ),

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
                            setState(() => _delete());                          },
                        )
                    ),
                  ],
                )
              ),
            ],
          )
        ),
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

  void updateTitle() {
    recommendation.title = titleController.text;
  }

  void updateComment() {
    recommendation.comment = commentController.text;
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
    showDialog(
      context: context,
      builder: (_) => alertDialog
    );
  }
}