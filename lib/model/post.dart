// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

List<Post?>? postFromJson(String str) => json.decode(str) == null
    ? []
    : List<Post?>.from(json.decode(str)!.map((x) => Post.fromJson(x)));

String postToJson(List<Post?>? data) => json.encode(
    data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())));

class Post {
  Post({
    this.userId,
    this.id,
    this.title,
    this.body,
    this.pic,
  });

  int? userId;
  int? id;
  String? title;
  String? body;
  String? pic;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
        pic: json["pic"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
        "pic": pic,
      };
}
