import 'package:flutter/material.dart';

import 'package:kaleidoscope/pages/feed.dart';
import 'package:kaleidoscope/pages/recommend.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}


class MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  int _selectedIndex = 0;

  FeedPage _feedPage;
  RecommendPage _recommendPage;
  List<Widget> _children;

  final navigatorKey = GlobalKey<NavigatorState>();

  MyAppState() {

    this._feedPage = new FeedPage(title: "Feed Page",);
    this._recommendPage = new RecommendPage(title: "Recommend Page");

    this._children = [
      this._feedPage,
      this._recommendPage,
    ];
  }

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kaleidoscope',
      theme: ThemeData(
        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          title: Text("Kaleidoscope"),
        ),
        body: _children[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.language), label: 'Feed'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'For You'),
//            BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Insights'),
          ],
          currentIndex: _selectedIndex,
          fixedColor: Colors.lightBlue,
          type: BottomNavigationBarType.fixed,
          onTap: _onItemTapped,
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

}


