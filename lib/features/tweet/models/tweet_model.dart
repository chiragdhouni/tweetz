// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TweetModel {
  final String tweetId;
  final String content;
  final DateTime createdAt;
  final String adminId;

  TweetModel(
      {required this.tweetId,
      required this.content,
      required this.createdAt,
      required this.adminId});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tweetId': tweetId,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'adminId': adminId,
    };
  }

  factory TweetModel.fromMap(Map<String, dynamic> map) {
    return TweetModel(
      tweetId: map['tweetId'] as String,
      content: map['content'] as String,
      createdAt: DateTime.parse(map['createdAt']),
      adminId: map['adminId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TweetModel.fromJson(String source) =>
      TweetModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
