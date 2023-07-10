import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:novel_killer/model/chapter.dart';
import 'package:novel_killer/model/chapter_info.dart';

class NovelService {
  static const platform = MethodChannel('com.fiirb.dev/novels');

  Future<List<String>> listNovels() async {
    List<String> novelList;
    try {
      final List<String>? result = await platform.invokeMethod('getNovelList');
      novelList = result!.toList();
    } on PlatformException catch (e) {
      novelList = ["Failed list of novels: '${e.message}'."];
    }

    return novelList;
  }

  Future<List<ChapterInfo>> listNovelChapters() async {
    List<ChapterInfo> novelList;
    try {
      final String? result = await platform.invokeMethod('getNovelChapterList');
      novelList = (json.decode(result!) as List)
          .map((e) => ChapterInfo.fromJson(e))
          .toList();
    } on PlatformException catch (e) {
      print('Error: ${e.message!}');
      novelList = [];
    }

    return novelList;
  }

  Future<Chapter> readChapter(String chapterLink) async {
    Chapter chapter = Chapter(content: ["Failed to retrieve content"]);
    try {
      var chapterContent = await platform
          .invokeMethod('getNovelChapter', <String, dynamic?>{'url': chapterLink}) as List;
      chapter = Chapter(content: chapterContent.map((e) => e as String).toList());
    } on Exception catch (e) {
      print('Error: $e');
    }

    return chapter;
  }
}
