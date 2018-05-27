import 'package:catbox/ui/cat_list.dart';
import 'package:flutter/material.dart';

void main() async => runApp(new CatBoxApp());

class CatBoxApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.pink,
          fontFamily: 'Ubuntu'
      ),
      home: new CatList(),
    );
  }
}
