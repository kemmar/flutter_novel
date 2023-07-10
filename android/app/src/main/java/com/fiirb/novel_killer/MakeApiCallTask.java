package com.fiirb.novel_killer;

import android.os.AsyncTask;
import android.os.Build;

import androidx.annotation.RequiresApi;

import com.squareup.okhttp.OkHttpClient;
import com.squareup.okhttp.Request;
import com.squareup.okhttp.Response;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;

import java.io.IOException;
import java.util.Collections;
import java.util.List;
import java.util.Locale;
import java.util.concurrent.ExecutionException;
import java.util.stream.Collectors;

class MakeApiCallTask extends AsyncTask<String, Void, String> {

    private Exception exception;

    OkHttpClient client = new OkHttpClient();

    protected String doInBackground(String... urls) {
        try {
            Request request = new Request.Builder()
                    .url(urls[0])
                    .get()
                    .build();
            try {
                Response response = client.newCall(request).execute();
                return response.body().string();
            } catch (IOException e) {
                e.printStackTrace();
                return e.getMessage();
            }

        } catch (Exception e) {
            this.exception = e;

            return null;
        }
    }

    protected void onPostExecute(String result) {

    }
}
