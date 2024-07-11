import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_workshop_tweet_app/core/config.dart';

class CreateTweetRepo {
  static Future<bool> postTweetRepo(
      String tweetId, adminId, content, DateTime createdAt) async {
    Dio dio = Dio();
    try {
      Response response = await dio.post(
        Config.serverURL + 'tweet',
        data: {
          "tweetId": tweetId,
          "adminId": adminId,
          "content": content,
          "createdAt": createdAt.toIso8601String(),
        },
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
