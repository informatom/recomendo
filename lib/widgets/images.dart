import 'package:flutter/material.dart';
import 'package:recomendo/models/recommendation.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'package:recomendo/screens/recommendation_detail.dart';

class Images extends StatelessWidget {
  const Images({
    Key key,
    @required this.recommendation, this.state,
  }) : super(key: key);

  final Recommendation recommendation;
  final RecommendationDetailState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
        EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            // Image 1
            Row(children: <Widget>[
              Expanded(
                  child: getImageWidget(recommendation.imageOne)),
              Expanded(
                  child: RaisedButton(
                      onPressed: getImage,
                      child: Text("Pick Photo 1")))
            ]),

            // Image 2
            Row(children: <Widget>[
              Expanded(
                  child: getImageWidget(recommendation.imageTwo)),
              Expanded(
                  child: RaisedButton(
                      onPressed: getImage,
                      child: Text("Pick Photo 2")))
            ]),

            // Image 3
            Row(children: <Widget>[
              Expanded(
                  child: getImageWidget(recommendation.imageThree)),
              Expanded(
                  child: RaisedButton(
                      onPressed: getImage,
                      child: Text("Pick Photo 3")))
            ]),
          ],
        ));
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    state.setState(() {
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
