import 'package:flutter/material.dart';
import 'package:recomendo/models/recommendation.dart';
import 'package:recomendo/utils/database_helper.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

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
              Row(children: <Widget>[
                Expanded(
                    child: Text("Category", style: textStyle)),
                Expanded(
                  child: DropdownButton(
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
                  )
                ),
              ]),

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
              Divider(),

              // Location
              Center(child:
                Text("Location", style: textStyle)
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text("Longitude: ${recommendation.longitude.toString()}")
                    ),
                    Expanded(
                      child: Text("Latitude: ${recommendation.longitude.toString()}")
                    ),
                  ]
                )
              ),
              Divider(),

              // Opening hours
              Center(
                  child: Text("Opening hours", style: textStyle)
              ),
              // Monday opening hours
              Row(
                children: <Widget>[
                  // moFrom
                  Expanded(
                    child: DateTimePickerFormField(
                      inputType: InputType.time,
                      format: DateFormat("HH:mm"),
                      initialValue: DateTime(0,0,0,
                          recommendation.moFrom.hour,
                          recommendation.moFrom.minute),
                      initialTime: TimeOfDay(
                          hour: recommendation.moFrom.hour,
                          minute: recommendation.moFrom.minute),
                      editable: false,
                      decoration: InputDecoration(
                          labelText: 'Monday from',
                          hasFloatingPlaceholder: true
                      ),
                      onChanged: (timeSelected) {
                        recommendation.moFrom = TimeOfDay(
                            hour: timeSelected.hour,
                            minute: timeSelected.minute
                        );
                      },
                    ),
                  ),

                  // moTill
                  Expanded(
                    child: DateTimePickerFormField(
                      inputType: InputType.time,
                      format: DateFormat("HH:mm"),
                      initialValue: DateTime(0,0,0,
                          recommendation.moTill.hour,
                          recommendation.moTill.minute),
                      initialTime: TimeOfDay(
                          hour: recommendation.moTill.hour,
                          minute: recommendation.moTill.minute),
                      editable: false,
                      decoration: InputDecoration(
                        labelText: 'Monday until',
                        hasFloatingPlaceholder: true
                      ),
                      onChanged: (timeSelected) {
                        recommendation.moTill = TimeOfDay(
                          hour: timeSelected.hour,
                          minute: timeSelected.minute
                        );
                      },
                    ),
                  ),
                ],
              ),

              // Tuesday opening hours
              Row(
                children: <Widget>[
                  // tueFrom
                  Expanded(
                    child: DateTimePickerFormField(
                      inputType: InputType.time,
                      format: DateFormat("HH:mm"),
                      initialValue: DateTime(0,0,0,
                          recommendation.tueFrom.hour,
                          recommendation.tueFrom.minute),
                      initialTime: TimeOfDay(
                          hour: recommendation.tueFrom.hour,
                          minute: recommendation.tueFrom.minute),
                      editable: false,
                      decoration: InputDecoration(
                          labelText: 'Tuesday from',
                          hasFloatingPlaceholder: true
                      ),
                      onChanged: (timeSelected) {
                        recommendation.tueFrom = TimeOfDay(
                            hour: timeSelected.hour,
                            minute: timeSelected.minute
                        );
                      },
                    ),
                  ),

                  // tueTill
                  Expanded(
                    child: DateTimePickerFormField(
                      inputType: InputType.time,
                      format: DateFormat("HH:mm"),
                      initialValue: DateTime(0,0,0,
                          recommendation.tueTill.hour,
                          recommendation.tueTill.minute),
                      initialTime: TimeOfDay(
                          hour: recommendation.tueTill.hour,
                          minute: recommendation.tueTill.minute),
                      editable: false,
                      decoration: InputDecoration(
                          labelText: 'Tuesday until',
                          hasFloatingPlaceholder: true
                      ),
                      onChanged: (timeSelected) {
                        recommendation.tueTill = TimeOfDay(
                            hour: timeSelected.hour,
                            minute: timeSelected.minute
                        );
                      },
                    ),
                  ),
                ],
              ),

              // Wednesday opening hours
              Row(
                children: <Widget>[
                  // wedFrom
                  Expanded(
                    child: DateTimePickerFormField(
                      inputType: InputType.time,
                      format: DateFormat("HH:mm"),
                      initialValue: DateTime(0,0,0,
                          recommendation.wedFrom.hour,
                          recommendation.wedFrom.minute),
                      initialTime: TimeOfDay(
                          hour: recommendation.wedFrom.hour,
                          minute: recommendation.wedFrom.minute),
                      editable: false,
                      decoration: InputDecoration(
                          labelText: 'Wednesday from',
                          hasFloatingPlaceholder: true
                      ),
                      onChanged: (timeSelected) {
                        recommendation.wedFrom = TimeOfDay(
                            hour: timeSelected.hour,
                            minute: timeSelected.minute
                        );
                      },
                    ),
                  ),

                  // wedTill
                  Expanded(
                    child: DateTimePickerFormField(
                      inputType: InputType.time,
                      format: DateFormat("HH:mm"),
                      initialValue: DateTime(0,0,0,
                          recommendation.wedTill.hour,
                          recommendation.wedTill.minute),
                      initialTime: TimeOfDay(
                          hour: recommendation.wedTill.hour,
                          minute: recommendation.wedTill.minute),
                      editable: false,
                      decoration: InputDecoration(
                          labelText: 'Wednesday until',
                          hasFloatingPlaceholder: true
                      ),
                      onChanged: (timeSelected) {
                        recommendation.wedTill = TimeOfDay(
                            hour: timeSelected.hour,
                            minute: timeSelected.minute
                        );
                      },
                    ),
                  ),
                ],
              ),

              // Thursday opening hours
              Row(
                children: <Widget>[
                  // thurFrom
                  Expanded(
                    child: DateTimePickerFormField(
                      inputType: InputType.time,
                      format: DateFormat("HH:mm"),
                      initialValue: DateTime(0,0,0,
                          recommendation.thurFrom.hour,
                          recommendation.thurFrom.minute),
                      initialTime: TimeOfDay(
                          hour: recommendation.thurFrom.hour,
                          minute: recommendation.thurFrom.minute),
                      editable: false,
                      decoration: InputDecoration(
                          labelText: 'Thursday from',
                          hasFloatingPlaceholder: true
                      ),
                      onChanged: (timeSelected) {
                        recommendation.thurFrom = TimeOfDay(
                            hour: timeSelected.hour,
                            minute: timeSelected.minute
                        );
                      },
                    ),
                  ),

                  // thurTill
                  Expanded(
                    child: DateTimePickerFormField(
                      inputType: InputType.time,
                      format: DateFormat("HH:mm"),
                      initialValue: DateTime(0,0,0,
                          recommendation.thurTill.hour,
                          recommendation.thurTill.minute),
                      initialTime: TimeOfDay(
                          hour: recommendation.thurTill.hour,
                          minute: recommendation.thurTill.minute),
                      editable: false,
                      decoration: InputDecoration(
                          labelText: 'Thursday until',
                          hasFloatingPlaceholder: true
                      ),
                      onChanged: (timeSelected) {
                        recommendation.thurTill = TimeOfDay(
                            hour: timeSelected.hour,
                            minute: timeSelected.minute
                        );
                      },
                    ),
                  ),
                ],
              ),

              // Friday opening hours
              Row(
                children: <Widget>[
                  // friFrom
                  Expanded(
                    child: DateTimePickerFormField(
                      inputType: InputType.time,
                      format: DateFormat("HH:mm"),
                      initialValue: DateTime(0,0,0,
                          recommendation.friFrom.hour,
                          recommendation.friFrom.minute),
                      initialTime: TimeOfDay(
                          hour: recommendation.friFrom.hour,
                          minute: recommendation.friFrom.minute),
                      editable: false,
                      decoration: InputDecoration(
                          labelText: 'Friday from',
                          hasFloatingPlaceholder: true
                      ),
                      onChanged: (timeSelected) {
                        recommendation.friFrom = TimeOfDay(
                            hour: timeSelected.hour,
                            minute: timeSelected.minute
                        );
                      },
                    ),
                  ),

                  // friTill
                  Expanded(
                    child: DateTimePickerFormField(
                      inputType: InputType.time,
                      format: DateFormat("HH:mm"),
                      initialValue: DateTime(0,0,0,
                          recommendation.friTill.hour,
                          recommendation.friTill.minute),
                      initialTime: TimeOfDay(
                          hour: recommendation.friTill.hour,
                          minute: recommendation.friTill.minute),
                      editable: false,
                      decoration: InputDecoration(
                          labelText: 'Friday until',
                          hasFloatingPlaceholder: true
                      ),
                      onChanged: (timeSelected) {
                        recommendation.friTill = TimeOfDay(
                            hour: timeSelected.hour,
                            minute: timeSelected.minute
                        );
                      },
                    ),
                  ),
                ],
              ),

              // Saturday opening hours
              Row(
                children: <Widget>[
                  // satFrom
                  Expanded(
                    child: DateTimePickerFormField(
                      inputType: InputType.time,
                      format: DateFormat("HH:mm"),
                      initialValue: DateTime(0,0,0,
                          recommendation.satFrom.hour,
                          recommendation.satFrom.minute),
                      initialTime: TimeOfDay(
                          hour: recommendation.satFrom.hour,
                          minute: recommendation.satFrom.minute),
                      editable: false,
                      decoration: InputDecoration(
                          labelText: 'Saturday from',
                          hasFloatingPlaceholder: true
                      ),
                      onChanged: (timeSelected) {
                        recommendation.satFrom = TimeOfDay(
                            hour: timeSelected.hour,
                            minute: timeSelected.minute
                        );
                      },
                    ),
                  ),

                  // satTill
                  Expanded(
                    child: DateTimePickerFormField(
                      inputType: InputType.time,
                      format: DateFormat("HH:mm"),
                      initialValue: DateTime(0,0,0,
                          recommendation.satTill.hour,
                          recommendation.satTill.minute),
                      initialTime: TimeOfDay(
                          hour: recommendation.satTill.hour,
                          minute: recommendation.satTill.minute),
                      editable: false,
                      decoration: InputDecoration(
                          labelText: 'Saturday until',
                          hasFloatingPlaceholder: true
                      ),
                      onChanged: (timeSelected) {
                        recommendation.satTill = TimeOfDay(
                            hour: timeSelected.hour,
                            minute: timeSelected.minute
                        );
                      },
                    ),
                  ),
                ],
              ),

              // Sunday opening hours
              Row(
                children: <Widget>[
                  // sunFrom
                  Expanded(
                    child: DateTimePickerFormField(
                      inputType: InputType.time,
                      format: DateFormat("HH:mm"),
                      initialValue: DateTime(0,0,0,
                          recommendation.sunFrom.hour,
                          recommendation.sunFrom.minute),
                      initialTime: TimeOfDay(
                          hour: recommendation.sunFrom.hour,
                          minute: recommendation.sunFrom.minute),
                      editable: false,
                      decoration: InputDecoration(
                          labelText: 'Sunday from',
                          hasFloatingPlaceholder: true
                      ),
                      onChanged: (timeSelected) {
                        recommendation.sunFrom = TimeOfDay(
                            hour: timeSelected.hour,
                            minute: timeSelected.minute
                        );
                      },
                    ),
                  ),

                  // sunTill
                  Expanded(
                    child: DateTimePickerFormField(
                      inputType: InputType.time,
                      format: DateFormat("HH:mm"),
                      initialValue: DateTime(0,0,0,
                          recommendation.sunTill.hour,
                          recommendation.sunTill.minute),
                      initialTime: TimeOfDay(
                          hour: recommendation.sunTill.hour,
                          minute: recommendation.sunTill.minute),
                      editable: false,
                      decoration: InputDecoration(
                          labelText: 'Sunday until',
                          hasFloatingPlaceholder: true
                      ),
                      onChanged: (timeSelected) {
                        recommendation.sunTill = TimeOfDay(
                            hour: timeSelected.hour,
                            minute: timeSelected.minute
                        );
                      },
                    ),
                  ),
                ],
              ),

              // Holiday opening hours
              Row(
                children: <Widget>[
                  // holidayFrom
                  Expanded(
                    child: DateTimePickerFormField(
                      inputType: InputType.time,
                      format: DateFormat("HH:mm"),
                      initialValue: DateTime(0,0,0,
                          recommendation.holidayFrom.hour,
                          recommendation.holidayFrom.minute),
                      initialTime: TimeOfDay(
                          hour: recommendation.holidayFrom.hour,
                          minute: recommendation.holidayFrom.minute),
                      editable: false,
                      decoration: InputDecoration(
                          labelText: 'Holiday from',
                          hasFloatingPlaceholder: true
                      ),
                      onChanged: (timeSelected) {
                        recommendation.holidayFrom = TimeOfDay(
                            hour: timeSelected.hour,
                            minute: timeSelected.minute
                        );
                      },
                    ),
                  ),

                  // holidayTill
                  Expanded(
                    child: DateTimePickerFormField(
                      inputType: InputType.time,
                      format: DateFormat("HH:mm"),
                      initialValue: DateTime(0,0,0,
                          recommendation.holidayTill.hour,
                          recommendation.holidayTill.minute),
                      initialTime: TimeOfDay(
                          hour: recommendation.holidayTill.hour,
                          minute: recommendation.holidayTill.minute),
                      editable: false,
                      decoration: InputDecoration(
                          labelText: 'Holiday until',
                          hasFloatingPlaceholder: true
                      ),
                      onChanged: (timeSelected) {
                        recommendation.holidayTill = TimeOfDay(
                            hour: timeSelected.hour,
                            minute: timeSelected.minute
                        );
                      },
                    ),
                  ),
                ],
              ),

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