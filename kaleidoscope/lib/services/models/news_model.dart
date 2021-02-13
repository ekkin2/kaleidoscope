import 'dart:convert';

class News {
  String id;
  String title;
  String source;
  String link;
  String imageLink;
  int polarity;
  int objectivity;
  List<String> sentences;
  List<String> facts;
  DateTime timestamp;

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

  factory News.fromMap(Map<String, dynamic> data, String id) {
    if (data == null) return null;

    final title = data["title"] as String;
    final source = data["description"] as String;
    final link = data["link"] as String;
    final timestamp = data["timestamp"].toDate();

    return News(
      id: id,
      title: title,
      source: source,

    );
  }

  Map<String, dynamic> toMap() => {

  };

}