/*
 * This file contains http get requests to get data from the server.
 */

import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:kaleidoscope/services/models/news_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

String apiLoc = "http://192.168.1.68:5000/";

// This function parses one news article
List<News> parseNews(String responseBody) {
  // print(responseBody);
  final parsed = json.decode(responseBody)['articles'].cast<Map<String, dynamic>>();
  return parsed.map<News>((json) => News.fromJson(json)).toList();
}

Future<List<News>> fetchNews(String sort, String topic) {
  // todo: update this when we have topics
  if (sort == "Recent") {
    if (topic == "General")
      return fetchRecentNews();
    else
      return fetchRecentTopicNews(topic);
  } else {
    if (topic == "General")
      return fetchRecentObjectiveNews();
    else
      return fetchObjectiveTopicNews(topic);
  }
}

Future<List<News>> fetchRecentNews() async {
  final response = await http.get(apiLoc + '/api/articles/?' + 'sorts=recent');

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
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  int avg = _prefs.getInt('polavg') ?? 50;
  final response = await http.get(apiLoc + '/api/articles/?' + 'sorts=polarity' + '&score=' + avg.toString());

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

Future<List<News>> fetchRecentTopicNews(String topic) async {
  final response = await http.get(apiLoc + '/api/articles/' + '?sorts=recent' + '&category=' + topic.toLowerCase());

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


Future<List<News>> fetchObjectiveTopicNews(String topic) async {
  final response = await http.get(apiLoc + '/api/articles/' + '?sorts=objectives' + '&category=' + topic.toLowerCase());

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

Future<List<News>> fetchRecentObjectiveNews() async {
  final response = await http.get(apiLoc + '/api/articles/' + '?sorts=objectives');

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
