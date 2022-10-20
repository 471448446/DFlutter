import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:part_practise/utils/ui.dart';

/// 点击后变更颜色
class GestureRecognizerRoutePage extends SimplePageRoute {
  GestureRecognizerRoutePage({super.key}) : super('GestureRecognizer提现');

  @override
  Widget pageBody(BuildContext context) => _Page();
}

class _Page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageState();
}

class _PageState extends State<_Page> {
  late TapGestureRecognizer _recognizer;
  MaterialColor _colors = Colors.green;
  final list = [Colors.red, Colors.green, Colors.yellow, Colors.deepPurple];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _recognizer = TapGestureRecognizer()
      ..onTap = () {
        HapticFeedback.vibrate();// 来自于TextSpan的文档实例
        // 因为这里想实现，点击后改变颜色，所以需要使用 StatefulWidget
        setState(() {
          _colors = list[Random().nextInt(list.length)];
        });
      };
  }

  @override
  void dispose() {
    super.dispose();
    _recognizer.dispose();
  }

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          children: [
            Text.rich(TextSpan(
                text: "您好，",
                style: const TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: "世界！！！",
                    style: TextStyle(
                      color: _colors,
                      fontSize: 30,
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.wavy,
                    ),
                    recognizer: _recognizer,
                    mouseCursor: SystemMouseCursors.precise,
                  ),
                  const TextSpan(
                    text: "，您好",
                    style: TextStyle(color: Colors.black),
                  )
                ])),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Text("点击上面文字中的\"世界\"，手机会震动噢"),
            )
          ],
        ),
      );
}
