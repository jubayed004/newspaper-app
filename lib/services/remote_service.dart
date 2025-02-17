import 'dart:convert';

import 'package:newspaper_app/model/news.dart';

import 'package:http/http.dart' as http;

class RemoteServices {
  Future<News?> getNews() async {
    var client = http.Client();
    var uri = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=a25f7add7f4d4b279778fe9b28f0d9c1');
    var response = await client.get(uri);
    if (response.statusCode == 200){
        var data = jsonDecode(response.body);
        return  News.fromJson(data);
    }else{
      return null;
    }
    }
  }

