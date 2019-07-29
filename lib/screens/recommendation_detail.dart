import 'package:flutter/material.dart';
import 'package:recomendo/models/recommendation.dart';
import 'package:recomendo/utils/database_helper.dart';
import 'package:recomendo/widgets/images.dart';
import 'package:recomendo/widgets/opening_hours.dart';
import 'package:recomendo/widgets/main_data.dart';

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
  DatabaseHelper helper = DatabaseHelper();
  String appBarTitle;
  Recommendation recommendation;

  RecommendationDetailState(this.recommendation, this.appBarTitle);

  @override
  Widget build(BuildContext context) {


    return WillPopScope(
      onWillPop: () {
        moveToLastScreen();
      },
      child: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.location_on)),
                  Tab(icon: Icon(Icons.image)),
                  Tab(icon: Icon(Icons.access_time)),
                ],
              ),
              title: Text(appBarTitle),
            ),
            body: TabBarView(
              children: [
                MainData(recommendation: recommendation, state: this, helper: helper),
                Images(recommendation: recommendation, state: this),
                OpeningHours(recommendation: recommendation),
              ],
            ),
          ),
        ),
      );
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }
}