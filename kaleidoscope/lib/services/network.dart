import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:kaleidoscope/services/models/news_model.dart';

/*
 * This file contains http get requests to get data from the server.
 */
Future<News> fetchRecentArticles() async {
  final response = await http.get('https://jsonplaceholder.typicode.com/albums/1');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return News.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load feed');
  }

}