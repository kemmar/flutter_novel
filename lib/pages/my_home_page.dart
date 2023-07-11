import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:novel_killer/model/chapter_info.dart';
import 'package:novel_killer/model/chapter_page.dart';
import 'package:novel_killer/pages/chapter_page.dart';
import 'package:novel_killer/pages/novel_page.dart';
import 'package:novel_killer/services/novel_service.dart';

import '../main.dart';
import '../model/novel_info.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  NovelService novelService = NovelService();

  List<NovelInfo> _novelList = List.empty();

  String searchParam = "";

  void _transition(String title, String url) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => NovelPage(
              title: title,
              url: url)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: searchBar(),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
            children: _novelList
                .map((e) => Card(
                        child: ListTile(
                      leading: Image.network(e.cover!),
                      title: Text(e.name!),
                      trailing: const Icon(Icons.more_vert),
                      dense: false,
                          onLongPress: () => _transition(e.name!, e.url!),
                    )))
                .toList()),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

   void _search(String searchTerm)  {
    novelService.searchForNovels(searchTerm).then((value) =>
        setState(() {
          _novelList = value;
        })
    );
  }

  List<Widget> searchBar() {
    return [
    SizedBox(
      width: 250,
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Search',
        ),
        onSubmitted: (String str) => _search(str),
      ),
      ),
    ];
  }
}
