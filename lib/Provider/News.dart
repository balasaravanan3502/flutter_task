import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class News with ChangeNotifier {
  final url = 'https://api.first.org/data/v1/news';

  Future<List> getNews() async {
    List news = [];
    try {
      final response = await http.get(Uri.parse(url));
      news.addAll(json.decode(response.body)['data']);
      print(news);
    } catch (error) {
      print(error);
    }
    return news;
  }
}
