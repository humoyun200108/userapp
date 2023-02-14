import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive/hive.dart';
import 'package:news/model/user_model.dart';
import 'package:news/repository/user_repository.dart';
import 'package:news/services/get_user.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("User App")),
        body: FutureBuilder(
          future: UserRepository().getUser(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (snapshot.data is String) {
              return Center(child: Text(snapshot.data));
            } else {
              Box<UserModel> data = snapshot.data as Box<UserModel>;
              return ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(data.getAt(index)!.name.toString()),
                    subtitle: Text(data.getAt(index)!.address.toString()),
                  );
                },
                itemCount: data.length,
              );
            }
          },
        ));
  }
}
