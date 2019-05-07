import 'package:flutter/material.dart';
import 'screens/recommendation_list.dart';

void main() {
  runApp(
      Recomendo()
  );
}

class Recomendo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Recomendo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red
        ),
        home: RecommendationList(),
    );
  }
}