package com.fiirb.novel_killer;

import android.annotation.TargetApi;
import android.os.Build;

import androidx.annotation.RequiresApi;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fiirb.novel_killer.models.NovelChapterModel;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.concurrent.ExecutionException;
import java.util.stream.Collectors;

import com.fasterxml.jackson.databind.ObjectMapper;

public class NovelService {

    @TargetApi(Build.VERSION_CODES.CUPCAKE)
    public static String getChapterList(String novelUrl) {
        String returnValue = "[]";
        ObjectMapper obj = new ObjectMapper();

        try {
            String result = new MakeGetApiCallTask()
                    .execute(novelUrl)
                    .get();

            Document doc = Jsoup.parse(result);

            List<NovelChapterModel> chapters = doc
                    .select("div.chp-item a[href]")
                    .stream()
                    .map(e ->
                            {
                                String title = e.attr("title");
                                String url = e.attr("href");

                                NovelChapterModel chapterInfo = new NovelChapterModel();

                                chapterInfo.setChapterTitle(title);
                                chapterInfo.setChapterLink(url);

                                return chapterInfo;
                            }
                    )
                    .collect(Collectors.toList());

            Collections.reverse(chapters);

            returnValue = obj.writeValueAsString(chapters);

            return returnValue;
        } catch (ExecutionException e) {
            e.printStackTrace();
        } catch (InterruptedException e) {
            e.printStackTrace();
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }

        return returnValue;
    }

    @TargetApi(Build.VERSION_CODES.CUPCAKE)
    public static List<String> getChapter(String url) {
        List<String> returnValue = new ArrayList<String>();

        try {
            String result = new MakeGetApiCallTask()
                    .execute(url)
                    .get();


            Document doc = Jsoup.parse(result);

            returnValue = doc
                    .select("div.overflow-hidden > p").stream().map(Element::text)
                    .collect(Collectors.toList());

            returnValue.remove(returnValue.size() - 1);

            return returnValue;
        } catch (ExecutionException e) {
            e.printStackTrace();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        return returnValue;
    }

    @TargetApi(Build.VERSION_CODES.CUPCAKE)
    public static String findNovels(String searchTerm) {

        String result = "[]";
        try {
            result = new MakePostApiCallTask()
                    .execute("https://www.novelcool.com/ajax/search/?term=" + searchTerm)
                    .get();

        } catch (ExecutionException e) {
            e.printStackTrace();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        return result;
    }
}
