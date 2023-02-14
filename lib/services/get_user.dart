import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news/model/user_model.dart';

class GetUserService {
  Future<dynamic> getUser() async {
    try {
      Response response = await Dio(BaseOptions(
        validateStatus: (status) {
          if (status! >= 100 && status <= 599) {
            return true;
          } else {
            return false;
          }
        },
      )).get("https://jsonplaceholder.typicode.com/users");

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        return response.statusMessage.toString();
      }
    } catch (e) {
      print(e);
    }
  }
}
