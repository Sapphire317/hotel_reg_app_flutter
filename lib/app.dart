// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'supplemental/cut_corners_border.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app_translations_delegate.dart';
import 'application.dart';



import 'home.dart';
import 'search.dart';
import 'mypage.dart';
import 'ranking.dart';
import 'favorite_hotels.dart';
import 'language_select.dart';
import 'detail.dart';

import 'colors.dart';

final ThemeData _kShrineTheme = _buildShrineTheme();


ThemeData _buildShrineTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    accentColor: Colors.blue,
    primaryColor:Colors.blue,
    buttonColor:kShrinePink100,
    scaffoldBackgroundColor: kShrineBackgroundWhite,
    cardColor: kShrineBackgroundWhite,
    textSelectionColor: kShrinePink100,
    errorColor: kShrineErrorRed,
    textTheme: _buildShrineTextTheme(base.textTheme),
    primaryTextTheme: _buildShrineTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildShrineTextTheme(base.accentTextTheme),
    primaryIconTheme: base.iconTheme.copyWith(color:Colors.white),
    inputDecorationTheme: InputDecorationTheme(border:CutCornersBorder(),)
  );
}

// TODO: Build a Shrine Text Theme (103)

TextTheme _buildShrineTextTheme(TextTheme base) {

  return base.copyWith(
    headline: base.headline.copyWith(
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    title: base.title.copyWith(
      fontSize: 20.0,
      color: Colors.white,
    ),
    caption: base.caption.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 10.0,
    ),
  ).apply(
    fontFamily: 'Rubik',
    displayColor: kShrineBrown900,
    bodyColor: kShrineBrown900,
  );
}


class ShrineApp extends StatefulWidget{

  @override
  _ShrineAppState createState() => _ShrineAppState();
}


// TODO: Convert ShrineApp to stateful widget (104)
class _ShrineAppState extends State<ShrineApp> {
  AppTranslationsDelegate _newLocaleDelegate;
   List<charts.Series> seriesList;

  @override
  void initState() {
    super.initState();
    _newLocaleDelegate = AppTranslationsDelegate(newLocale: null);
    application.onLocaleChanged = onLocaleChange;
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }



  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      localizationsDelegates: [
        _newLocaleDelegate,
        const AppTranslationsDelegate(),
        //provides localised strings
        GlobalMaterialLocalizations.delegate,
        //provides RTL support
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: application.supportedLocales(),
      title: 'Shrine',
      // TODO: Change home: to a Backdrop with a HomePage frontLayer (104)
      initialRoute: '/',
      routes: {
        // When we navigate to the "/" route, build the FirstScreen Widget
        '/': (context) => HomePage(),
        // When we navigate to the "/second" route, build the SecondScreen Widget
        '/0': (context) => HomePage(),
        '/1': (context) => ExpansionPanelsDemo(),
        '/2': (context) => Favorite_HotelsPage(),
        '/3': (context) => RankingPage(_createSampleData()),
        '/4': (context) => MyPage(),
        '/language': (context) => LanguageSelectorPage(),
        '/detail': (context) => DetailPage(),

      },

      // TODO: Add a theme (103)
      theme: _kShrineTheme,
    );

    }



  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final data = [
      new OrdinalSales('2014', 5),
      new OrdinalSales('2015', 25),
      new OrdinalSales('2016', 100),
      new OrdinalSales('2017', 75),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
  }

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}