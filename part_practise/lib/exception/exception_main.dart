import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../utils/ui.dart';

/// 异常
/// 1.根据异常代码的执行时序，Dart异常可以分为同步异常和异步异常两类。
/// 对于同步异常，可以使用try-catch机制来进行捕获，
/// 而异步异常的捕获则比较麻烦，需要使用Future提供的catchError语句来进行捕获
/// 2.Framework异常指的是Flutter框架引起的异常，通常是由于执行错误的应用代码造成Flutter框架底层异常判断引起的，当出现Framework异常时，系统会自动弹出一个的红色错误界面
/// 可以自定义错误页面
/// https://segmentfault.com/a/1190000022280728
class ErrWidget extends StatelessWidget {
  const ErrWidget({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const TextTitleWidget("Handle Error"),
          Row(
            children: [
              TextEntranceWidget.createEntrance(context, "try-catch", () {
                // dart：同步异常
                try {
                  throw Exception("Test throw one exception!!!");
                } catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                }
              }),
              TextEntranceWidget.createEntrance(context, "框架捕获异常", () {
                // 使用框架统一处理 dart同步或者异步
                Future.delayed(const Duration(seconds: 1))
                    .then((value) => throw Future.error("Test throw async exception!!!"));
                throw Exception("Test throw one exception!!!");
              }),
              TextEntranceWidget.createEntrance(context, "异步异常", () {
                //  dart：异步异常
                // 以下这种异步的异常，虽然使用try-catch，但是是无法捕获的
                // 需要使用catchError
                try {
                  Future.delayed(const Duration(seconds: 1))
                      .then((e) =>
                          Future.error("Test throw one async exception!!!"))
                      .catchError((e) => {
                            Fluttertoast.showToast(
                                msg: "async err catched!! $e")
                          });
                } catch (e) {
                  print(e);
                }
              }),
            ],
          )
        ],
      );
}
