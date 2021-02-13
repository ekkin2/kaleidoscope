import 'dart:convert';

import 'package:flutter/cupertino.dart';

class News {
  String id;
  String title;
  String source;
  String link;
  String imageLink;
  int polarity;
  int objectivity;
  List sentences;
  List facts;
  String timestamp; // todo: change back to DateTime

  News({
    this.id,
    this.title,
    this.source,
    this.link,
    this.imageLink,
    this.polarity,
    this.objectivity,
    this.sentences,
    this.facts,
    this.timestamp,
  });

  factory News.fromJson(Map<String, dynamic> data) {
    if (data == null) return null;

    final title = data["title"] as String;
    final source = data["description"] as String;
    final link = data["link"] as String;
    final imageLink = data["imageLink"] as String;
    final polarity = data["polarity"] as int;
    final objectivity = data["objectivity"] as int;
    final sentences = data["sentences"] as List;
    final facts = data["facts"] as List;
    final timestamp = data["timestamp"] as String;

    return News(
      title: title,
      source: source,
      link: link,
      imageLink: imageLink,
      polarity: polarity,
      objectivity: objectivity,
      sentences: sentences,
      facts: facts,
      timestamp: timestamp,
    );
  }

  Map<String, dynamic> toJson() => {

  };

}