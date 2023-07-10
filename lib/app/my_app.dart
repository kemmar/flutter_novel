import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:novel_killer/pages/my_home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Novel Lister',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Novel Killer'),
    );
  }
}