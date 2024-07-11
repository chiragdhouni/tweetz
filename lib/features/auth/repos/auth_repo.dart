// ignore_for_file: unused_local_variable

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_workshop_tweet_app/core/config.dart';
import 'package:flutter_workshop_tweet_app/features/auth/models/user_model.dart';

class AuthRepo {
  static Future<UserModel?> getUserRepo(String uid) async {
    Dio dio = Dio();
    try {
      log(uid);
      final response = await dio.get('${Config.serverURL}user/$uid');
      log(response.data.toString());
      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        UserModel userModel = UserModel.fromMap(response.data);
        return userModel;
      }

      UserModel userModel = UserModel.fromMap(response.data);
    } catch (e) {
      log(e.toString());
      return null;
    }
    return null;
  }

  static Future<bool> createUserRepo(UserModel userModel) async {
    Dio dio = Dio();
    try {
      final response =
          await dio.post('${Config.serverURL}user', data: userModel.toMap());
      // userModel = UserModel.fromMap(response.data);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return true;
      }
      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
