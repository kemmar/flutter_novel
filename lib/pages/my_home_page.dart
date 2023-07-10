import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:novel_killer/model/chapter_info.dart';
import 'package:novel_killer/model/chapter_page.dart';
import 'package:novel_killer/pages/chapter_page.dart';
import 'package:novel_killer/services/novel_service.dart';

import '../main.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  NovelService novelService = NovelService();

  List<ChapterInfo> _novelList = List.empty();

  void _action() {
    novelService.listNovelChapters().then((_novelListF) {
      setState(() {
        _novelList = _novelListF.toList();
      });
    });
  }

  void _goToChapterPage(int index, List<ChapterInfo> chapterList) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ChapterPage(
              chapterIndex: index,
              chapterInfoList: chapterList)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            children: _novelList
                .map((e) => Card(
                        child: ListTile(
                      leading: const Icon(
                        Icons.menu_book_sharp,
                      ),
                      title: Text(e.chapterTitle!),
                      trailing: const Icon(Icons.more_vert),
                      onTap: () {
                        _goToChapterPage(_novelList.indexOf(e), _novelList);
                      },
                      dense: false,
                    )))
                .toList()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _action,
        tooltip: 'Action',
        child:
            _novelList.isEmpty ? Icon(Icons.add) : Icon(Icons.download_rounded),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
