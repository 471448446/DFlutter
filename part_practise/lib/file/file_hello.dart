import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:part_practise/utils/ui.dart';
import 'package:path_provider/path_provider.dart';

/// 简单操作文件
/// Dart io库
/// shared_preferences插件
class FileHelloRoutePage extends SimplePageRoute {
  FileHelloRoutePage({super.key}) : super('File 操作');

  @override
  Widget pageBody(BuildContext context) => _Pages();
}

/// 计数器，重启应用后，可以恢复上次点击的数字
class _Pages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PagesState();
}

class _PagesState extends State<_Pages> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _readCounter().then((value) {
      setState(() {
        _counter = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) => Center(
          child: Column(
        children: [
          Text(
            "$_counter",
            textScaleFactor: 3,
          ),
          FloatingActionButton(
            onPressed: _incrementCounter,
            child: const Icon(Icons.add),
          )
        ],
      ));

  Future<File> _getFile() async {
    // 异步api写法
    var path2 = (await getApplicationDocumentsDirectory()).path;
    return File("$path2/counter.txt");
  }

  Future<int> _readCounter() async {
    try {
      var file = File((await _getFile()).path);
      var content = await file.readAsString();
      return int.parse(content);
    } catch (e) {
      print(e);
      return 0;
    }
  }

  _incrementCounter() async {
    setState(() {
      _counter++;
    });
    // 将点击次数以字符串类型写到文件中
    await (await _getFile()).writeAsString('$_counter');
  }
}
