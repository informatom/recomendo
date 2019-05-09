import 'package:flutter/material.dart';
import 'screens/recommendation_list.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'), // English
        const Locale('de'), // German
      ],
    );
  }
}