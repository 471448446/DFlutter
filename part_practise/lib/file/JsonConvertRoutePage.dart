import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:part_practise/utils/ui.dart';

class JsonConvertRoutePage extends SimplePageRoute {
  JsonConvertRoutePage({super.key}) : super('JSON 转换');

  @override
  Widget pageBody(BuildContext context) {
//一个JSON格式的用户列表字符串
    String jsonStr = '[{"name":"Jack"},{"name":"Rose"}]';
//将JSON字符串转为Dart对象(此处是List)
    List items = json.decode(jsonStr);
//输出第一个用户的姓名
    print(items[0]["name"]);

    // TODO: implement pageBody
    return const Center();
  }
}

class User {
  final String name;
  final String email;

  User(this.name, this.email);

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'email': email,
      };
}
