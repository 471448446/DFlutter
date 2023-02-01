import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:part_practise/utils/ui.dart';

/// 下面时三种方式，尝试取消一个Future。
/// Future本身是没有取消方法的
/// 转换为Stream后，Stream的结果是没有回调，但是Future.then是调研了的
class FutureCancelPages extends SimplePageRoute {
  FutureCancelPages({super.key}) : super('Future');

  @override
  Widget pageBody(BuildContext context) => _Pages();
}

class _Pages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PagesState();
}

class _PagesState extends State<_Pages> {
  cancelFuture() {
    Fluttertoast.showToast(msg: '观察日志输出');
    var task = Future.delayed(const Duration(seconds: 3))
        .then((value) => {print("1.使用future.ignore()失败!!!")});
    Future.delayed(const Duration(seconds: 2)).then((value) {
      print("1.使用ignore()取消");
      task.ignore();
    });

    //
    var task2 = Future.delayed(const Duration(seconds: 3))
        .then((value) => {print("2.使用CancelableOperation失败!!!")});
    var cancelableOperation =
        CancelableOperation.fromFuture(task2, onCancel: () {
      print("2.CancelableOperation取消回调");
    });
    Future.delayed(const Duration(seconds: 2))
        .then((value) => {cancelableOperation.cancel()});

    var task3 = Future.delayed(const Duration(seconds: 3))
        .then((value) => {print("3.使用Stream失败!!!")});
    var listen = task3.asStream().listen((event) {
      print('3.listen() invoke');
    });
    // listen 方法确实没有回调. Future.then()还是回调了
    Future.delayed(const Duration(seconds: 2)).then((value) {
      print("3.使用Stream取消");
      listen.cancel();
    });
  }

  @override
  Widget build(BuildContext context) => Center(
        child:
            ElevatedButton(onPressed: cancelFuture, child: const Text('Click')),
      );
}
