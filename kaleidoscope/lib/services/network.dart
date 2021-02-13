/*
 * This file contains http get requests to get data from the server.
 */

import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:kaleidoscope/services/models/news_model.dart';

// This function parses one news article
List<News> parseNews(String responseBody) {
  // print(responseBody);
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<News>((json) => News.fromJson(json)).toList();
}


Future<List<News>> fetchRecentNews() async {
  final response = await http.get('http://172.17.108.145:8000/articles.json');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return parseNews(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load feed');
  }
}

Future<List<News>> fetchPersonalNews() async {
  // todo: add specific thing here for sending polarity average
  final response = await http.get('http://172.17.108.145:8000/articles.json');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return parseNews(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load feed');
  }
}

Future<List<News>> fetchTopicNews(String topic) async {
  // todo: add specific thing here for sending specific topic
  final response = await http.get('http://172.17.108.145:8000/articles.json');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return parseNews(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load feed');
  }
}

Future<List<News>> fetchObjectiveNews() async {
  // todo: add specific thing here for sending that we want objective
  final response = await http.get('http://172.17.108.145:8000/articles.json');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return parseNews(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load feed');
  }
}
