import 'dart:async';
import 'package:flutter/material.dart';
import 'package:recomendo/models/recommendation.dart';
import 'package:recomendo/utils/database_helper.dart';
import 'package:recomendo/screens/recommendation_detail.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class RecommendationList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RecommendationListState();
  }
}

class RecommendationListState extends State<RecommendationList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Recommendation> recommendationList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (recommendationList == null) {
      recommendationList = List<Recommendation>();

      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Recommendations'),
      ),
      body: recommendationListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('FAB pressed');
          navigateToDetail(
              Recommendation(
                  1,              // category
                  DateTime.now(), // insertedAT
                  1,              // rating
                  '',             // title
                  DateTime.now()  // updatedAT
              ),
              'Add Recommendation'
          );
        },
        tooltip: 'Add Recommendation',
        child: Icon(Icons.add),
      ),
    );
  }

  ListView recommendationListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: getCategoryColor(this.recommendationList[position].category),
                child: getCategoryIcon(this.recommendationList[position].category),
              ),
              title: Text(
                  this.recommendationList[position].title,
                  style: titleStyle),
              subtitle: getDateText(this.recommendationList[position].updatedAt),
              trailing: GestureDetector(
                child: Icon(
                  Icons.delete,
                  color: Colors.grey,
                ),
                onTap: () {
                  _delete(context, recommendationList[position]);
                },
              ),
              onTap: () {
                debugPrint("ListTile tapped");
                navigateToDetail(
                    this.recommendationList[position],
                    'Edit Recommendation'
                );
              },
            ));
      },
    );
  }

  Color getCategoryColor(int category) {
    switch (category) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.blue;
        break;
      default:
        return Colors.green;
    }
  }

  Icon getCategoryIcon(int category) {
    switch (category) {
      case 1:
        return Icon(Icons.restaurant_menu);
        break;
      case 2:
        return Icon(Icons.fastfood);
        break;
      default:
        return Icon(Icons.local_offer);
    }
  }

  void _delete(BuildContext context, Recommendation recommendation) async {
    int result = await databaseHelper.deleteRecommendation(recommendation.id);

    if (result != 0) {
      _showSnackBar(context, 'Note deleted successfully');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigateToDetail(Recommendation recommendation, String title) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return RecommendationDetail(recommendation, title);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Recommendation>> recommendationListFuture = databaseHelper.getRecommendationList();
      recommendationListFuture.then((recommendationList) {
        setState(() {
          this.recommendationList = recommendationList;
          this.count = recommendationList.length;
        });
      });
    });
  }

  Text getDateText(value) {
    String dateString = DateFormat.yMMMd().format(value);
    return Text(dateString);
  }
}
