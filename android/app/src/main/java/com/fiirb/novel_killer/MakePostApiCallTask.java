package com.fiirb.novel_killer;

import android.os.AsyncTask;

import com.squareup.okhttp.MediaType;
import com.squareup.okhttp.OkHttpClient;
import com.squareup.okhttp.Request;
import com.squareup.okhttp.RequestBody;
import com.squareup.okhttp.Response;

import java.io.IOException;

class MakePostApiCallTask extends AsyncTask<String, Void, String> {

    private Exception exception;

    OkHttpClient client = new OkHttpClient();

    protected String doInBackground(String... urls) {
        try {
            Request request = new Request.Builder()
                    .url(urls[0])
                    .post(RequestBody.create(MediaType.parse("application/json"), ""))
                    .build();
            try {
                Response response = client.newCall(request).execute();
                String value =  response.body().string();

                System.out.println(value);
                return value;
            } catch (IOException e) {
                e.printStackTrace();
                return e.getMessage();
            }

        } catch (Exception e) {
            this.exception = e;

            e.printStackTrace();

            return "[]";
        }
    }

    protected void onPostExecute(String result) {

    }
}
