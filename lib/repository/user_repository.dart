import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:news/model/user_model.dart';
import 'package:news/services/get_user.dart';

class UserRepository {
  Box<UserModel> userBox = Hive.box<UserModel>("user");
  final GetUserService getUserService = GetUserService();

  Future<dynamic> getUser() async {
    dynamic response = await getUserService.getUser();
    if (response is UserModel) {
      await openBox();
      await writeToBox([response]);
      return userBox.values.first;
    } else {
      return response;
    }
  }

  Future<void> openBox() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocDir.path);
    registerAdapter();
    await Hive.openBox<UserModel>("user");
  }

  void registerAdapter() {
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(AddressAdapter());
    Hive.registerAdapter(GeoAdapter());
    Hive.registerAdapter(CompanyAdapter());
  }

  Future<void> writeToBox(List<UserModel> data) async {
    await userBox.clear();
    await userBox.addAll(data);
  }
}
