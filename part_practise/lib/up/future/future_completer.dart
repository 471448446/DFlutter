import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:part_practise/utils/ui.dart';

/// 类似于kotlin的SuspendCoroutine,代码执行到该处时，等待结果。
class FutureCompleterPage extends SimplePageRoute {
  var complete = Completer<String>();

  FutureCompleterPage({super.key}) : super('FutureCompleter');

  _trigResult() {
    Future.delayed(const Duration(seconds: 2))
        .then((value) => {complete.complete("response")});
  }

  _waitResultTimeOut() async {
    var result = await complete.future
        .timeout(const Duration(seconds: 1), onTimeout: () => "timeout");
    Fluttertoast.showToast(msg: result);
  }

  _waitResult() async {
    var result = await complete.future;
    Fluttertoast.showToast(msg: result);
  }

  @override
  Widget pageBody(BuildContext context) =>
      Center(
        child: ElevatedButton(
            onPressed: () {
              _waitResult();
              _waitResultTimeOut();
              _trigResult();
            },
            child: const Text('click')),
      );
}
