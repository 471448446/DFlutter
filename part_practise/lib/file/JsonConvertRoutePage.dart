import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:part_practise/file/UserBean.dart';
import 'package:part_practise/utils/ui.dart';

/// flutter中使用json：https://dart.cn/guides/json
/// 1. 借助`'dart:convert'`中的数据`jsonDecode()`、`jsonEncode()`
/// 2. json_serializable：https://pub.flutter-io.cn/packages/json_serializable
/// FlutterJsonBeanFactory 插件，辅助生成bean类文件
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
    List<dynamic> jsonEncode2 = jsonDecode(jsonStr);
    print("${jsonEncode2[0]['name']},${jsonEncode2[0]['email']}");
    try {
      List<dynamic> jsonEncode3 = jsonDecode('');
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: 'jsonDecode()转换可能会抛出异常');
    }
    // 自定义数据toJson
    var list = [User('张三', '1234@qq.com'), User('李四', '1111@qq.com')];
    // 使用convert，也不是很方便呢
    String jsonString = '{"name": "Tony","email": "tony@example.com"}';
    Map<String, dynamic> map = json.decode(jsonString);
    var user = UserBean.fromJson(map);
    var convertMap = user.toJson();
    var toJsonString = jsonEncode(convertMap);
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
                '转换后，取出数据：name:${jsonEncode2[0]['name']},email:${jsonEncode2[0]['email']}'),
            Text('转换成string：${jsonEncode(jsonEncode2)}'),
            Text('自定义类，toJson：${jsonEncode(list)}'),
            Text('自定义convert，toJson：$toJsonString'),
          ]
              .map((e) => Padding(
                    padding: const EdgeInsets.all(10),
                    child: e,
                  ))
              .toList(),
        ),
      ),
    );
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
