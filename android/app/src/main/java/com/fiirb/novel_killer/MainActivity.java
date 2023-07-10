package com.fiirb.novel_killer;

import android.os.Build;

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {

    private static final String CHANNEL = "com.fiirb.dev/novels";

    @RequiresApi(api = Build.VERSION_CODES.R)
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            System.out.println("Called: " + call.method);

                            switch (call.method) {
                                case "getNovelChapterList":
                                    result.success(NovelService.getChapterList("https://www.novelcool.com/novel/Mystic-God-level-Emperor-System.html"));
                                    break;
//                                case "getNovelChapter":
//                                    final String url = call.argument("url");
//                                    result.success(NovelService.getChapter(url));
//                                    break;
                                default:
                                    final String url = call.argument("url");
                                    result.success(NovelService.getChapter(url));
                                    break;
                            }


                        }
                );
    }

}

