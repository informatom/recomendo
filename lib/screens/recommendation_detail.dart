import 'package:flutter/material.dart';
import 'package:recomendo/models/recommendation.dart';
import 'package:recomendo/utils/database_helper.dart';
import 'package:recomendo/widgets/images.dart';
import 'package:recomendo/widgets/opening_hours.dart';
import 'package:recomendo/widgets/main_data.dart';
import 'package:recomendo/widgets/location_and_map.dart';
import 'package:recomendo/widgets/audio_comment.dart';
import 'package:recomendo/utils/geolocation_helper.dart';
import 'package:location/location.dart';

class RecommendationDetail extends StatefulWidget {
  final String appBarTitle;
  final Recommendation recommendation;
  RecommendationDetail(this.recommendation, this.appBarTitle);

  @override
  State<StatefulWidget> createState() => RecommendationDetailState();
}

class RecommendationDetailState extends State<RecommendationDetail> {
  DatabaseHelper helper = DatabaseHelper();
  Recommendation recommendation;

  @override
  void initState() {
    super.initState();
    recommendation = widget.recommendation;
    setCoordinates(recommendation, this);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        moveToLastScreen();
      },
      child: DefaultTabController(
          length: 5,
          child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(text: "Info", icon: Icon(Icons.event_note)),
                  Tab(text: "Location", icon: Icon(Icons.location_on)),
                  Tab(text: "Photos", icon: Icon(Icons.image)),
                  Tab(text: "Opening Hours", icon: Icon(Icons.access_time)),
                  Tab(text: "Audio Comment", icon: Icon(Icons.mic)),
                ],
              ),
              title: Text(widget.appBarTitle),
            ),
            body: TabBarView(
              children: [
                MainData(recommendation: recommendation, parentWidget: this, helper: helper),
                LocationAndMap(recommendation: recommendation),
                Images(recommendation: recommendation, parentWidget: this),
                OpeningHours(recommendation: recommendation),
                AudioComment(recommendation: recommendation, parentWidget: this)
              ],
            ),
          ),
        ),
      );
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  bool setCoordinates(recommendation, state) {
    final Future<LocationData> locationFuture = GeolocationHelper().location;

    locationFuture.then((location) {
      state.setState(() {
        recommendation.longitude = location.longitude;
        recommendation.latitude = location.latitude;
      });
    });
  }
}