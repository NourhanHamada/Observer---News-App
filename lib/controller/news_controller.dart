import 'dart:convert';
import 'package:http/http.dart' as http;


import '../constants/links.dart';
import '../model/news_model.dart';
import '../model/news_model_category.dart';

class NewsApi {
  static Future<List<NewsData>> getData() async {
    List<NewsData> newsData = [];
    var url =
    Uri.parse('${baseUrl}top-headlines?country=${country}&apiKey=$apiKey');
    // print('url==== $url');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      print('Success');
    } else if (response.statusCode == 404) {
      print('not found');
    } else if (response.statusCode == 500) {
      print('server not responding');
    } else {
      print('policy error');
    }

    var responseBody = jsonDecode(response.body)['articles'];
    // print('response === $responseBody');
    for (var i in responseBody) {
      newsData.add(
        NewsData(
          author: i['author'],
          name: i["source"]['name'],
          title: i['title'],
          description: i['description'],
          urlToImage: i['urlToImage'],
        ),
      );
    }
    return newsData;
  }

  static Future<List<NewsDataCategory>> getCategoryData(String category) async {
    List<NewsDataCategory> newsDataCategory = [];
    var url = Uri.parse(
        '${baseUrl}top-headlines?country=${country}&category=${category}&apiKey=${apiKey}');
    var response = await http.get(url);
    var responseBody = jsonDecode(response.body)['articles'];
    for (var i in responseBody) {
      newsDataCategory.add(NewsDataCategory(
        publishedAt: i['publishedAt'],
        title: i['title'],
        description: i['description'],
        url: i['url'],
        urlToImage: i['urlToImage'],
        name: i["source"]['name'],
      ));
    }
    return newsDataCategory;
  }
}
