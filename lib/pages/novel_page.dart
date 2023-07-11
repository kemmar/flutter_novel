import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:novel_killer/model/chapter_info.dart';
import 'package:novel_killer/model/chapter_page.dart';
import 'package:novel_killer/pages/chapter_page.dart';
import 'package:novel_killer/services/novel_service.dart';

import '../main.dart';

class NovelPage extends StatefulWidget {
  const NovelPage({Key? key, required this.title, required this.url}) : super(key: key);

  final String title;
  final String url;

  @override
  State<NovelPage> createState() => _NovelPageState();
}

class _NovelPageState extends State<NovelPage> {
  NovelService novelService = NovelService();

  List<ChapterInfo> _chapterList = List.empty();

  void _action() {
    novelService.listNovelChapters(widget.url).then((_novelListF) {
      setState(() {
        _chapterList = _novelListF.toList();
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
            children: _chapterList
                .map((e) => Card(
                        child: ListTile(
                      leading: const Icon(
                        Icons.menu_book_sharp,
                      ),
                      title: Text(e.chapterTitle!),
                      trailing: const Icon(Icons.more_vert),
                      onTap: () {
                        _goToChapterPage(_chapterList.indexOf(e), _chapterList);
                      },
                      dense: false,
                    )))
                .toList()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _action,
        tooltip: 'Action',
        child:
            _chapterList.isEmpty ? Icon(Icons.add) : Icon(Icons.download_rounded),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
