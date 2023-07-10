import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:novel_killer/model/chapter_info.dart';
import 'package:novel_killer/model/chapter_page.dart';
import 'package:novel_killer/services/novel_service.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

enum TtsState { playing, stopped, paused, continued }

class ChapterPage extends StatefulWidget {
  const ChapterPage(
      {Key? key, required this.chapterIndex, required this.chapterInfoList})
      : super(key: key);

  final int chapterIndex;
  final List<ChapterInfo> chapterInfoList;

  @override
  State<ChapterPage> createState() => _ChapterPageState();
}

class _ChapterPageState extends State<ChapterPage> {
  NovelService novelService = NovelService();
  late ChapterInfo chapterInfo;
  ChapterPageInfo chapterPageInfo = ChapterPageInfo();

  int paraIndex = 0;
  List<String> content = List.empty();

  late FlutterTts tts;

  @override
  void dispose() {
    super.dispose();
    tts.stop();
  }

  bool get isAndroid => !kIsWeb && Platform.isAndroid;

  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;

  get isStopped => ttsState == TtsState.stopped;

  get isPaused => ttsState == TtsState.paused;

  get isContinued => ttsState == TtsState.continued;

  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.4;

  final String defaultLanguage = 'en-US';
  String? language;

  void initTts() {
    tts = FlutterTts();

    _setAwaitOptions();

    if (isAndroid) {
      _getDefaultEngine();
      _getDefaultVoice();
    }

    if (isAndroid) {
      tts.setInitHandler(() {
        setState(() {
          print("TTS Initialized");
        });
      });
    }

    tts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        if(paraIndex < content.length) {
          paraIndex++;
          _speak();
        } else {
        ttsState = TtsState.stopped;
        }
      });
    });

    tts.setCancelHandler(() {
      setState(() {
        print("Cancel");
        ttsState = TtsState.stopped;
      });
    });

    tts.setPauseHandler(() {
      setState(() {
        print("Paused");
        ttsState = TtsState.paused;
      });
    });

    tts.setContinueHandler(() {
      setState(() {
        print("Continued");
        ttsState = TtsState.continued;
      });
    });

    tts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
  }

  void _getDefaultEngine() async {
    var engine = await tts.getDefaultEngine;
    if (engine != null) {
      print(engine);
    }
  }

  void _getDefaultVoice() async {
    var voice = await tts.getDefaultVoice;
    if (voice != null) {
      print(voice);
    }
  }

  void _speak() async {
    await tts.setVolume(volume);
    await tts.setSpeechRate(rate);
    await tts.setPitch(pitch);

    if (content.isNotEmpty) {
      var result = await tts.speak(content.elementAt(paraIndex));
      if (result == 1) setState(() => ttsState = TtsState.playing);
    }
  }

  void _stop() async {
    await tts.stop();
  }

  Future _setAwaitOptions() async {
    await tts.awaitSpeakCompletion(true);
  }

  void _transition(int index) async {
    _stop();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => ChapterPage(
              chapterIndex: index, chapterInfoList: widget.chapterInfoList)),
    );
  }

  void readSelected(int index) async {
    _stop();
    setState(() {
      paraIndex = index;
    });

    _speak();
  }

  void _previous() async {
    _transition(widget.chapterIndex - 1);
  }

  void _next() async {
    _transition(widget.chapterIndex + 1);
  }

  @override
  void initState() {
    initTts();
    super.initState();
    if (widget.chapterIndex >= 0 &&
        widget.chapterIndex < widget.chapterInfoList.length) {
      chapterInfo = widget.chapterInfoList.elementAt(widget.chapterIndex);

      novelService.readChapter(chapterInfo.chapterLink!).then((_novelChapter) {
        setState(() {
          chapterPageInfo = ChapterPageInfo(
              chapterTitle: chapterInfo.chapterTitle,
              chapterContent: _novelChapter.content);

          content = _novelChapter.content!;
        });
      });
    } else {
      chapterInfo = ChapterInfo(chapterLink: "None", chapterTitle: "Not Found");
      content = ["No Chapter Found"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(chapterInfo.chapterTitle!),
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: content.map((e) =>
            ListTile(
              title: Text(e),
              onTap: () { readSelected(content.indexOf(e)); },
              dense: false,
            )
            ).toList(),
          )
          ),
      persistentFooterButtons: navigationButtons(),
    );
  }

  List<Widget> navigationButtons() {
    return [
      IconButton(
          onPressed: () {
            _previous();
          },
          icon: const Icon(Icons.navigate_before_outlined)),
      IconButton(
        onPressed: () {
          _speak();
        },
        icon: const Icon(Icons.audiotrack),
      ),
      IconButton(
        onPressed: () {
          _next();
        },
        icon: const Icon(Icons.navigate_next_outlined),
      )
    ];
  }
}
