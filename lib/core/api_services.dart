// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:dio/dio.dart';
import '../module/home/model/user_model.dart';

class ApiService {
  static final Dio dio = Dio();

  static Future<List<User>> getUser(int listlength) async {
    List<User> usersList;
    try {
      Response userData = await dio
          .get("https://verified-mammal-79.hasura.app/api/rest/users", queryParameters: {"since":listlength});
      print('User Info: ${userData.data}');
      usersList = welcomeFromJson(jsonEncode(userData.data)).users ?? [];
      return usersList;
    } on DioError catch (e) {
      print(e.message);
    }
    return [];
  }
}
