import 'package:flutter/material.dart';
import '../utils/ui.dart';

/// 异常
class ErrWidget extends StatelessWidget {
  const ErrWidget({super.key});

  @override
  Widget build(BuildContext context) => Column(
    children: [
      const TextTitleWidget("Handle Error"),
      Row(
        children: [
          TextEntranceWidget.createEntrance(context, "try-catch", () {
            try {
              throw Exception("Test throw one exception!!!");
            } catch (e) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(e.toString())));
            }
          }),
          TextEntranceWidget.createEntrance(context, "框架捕获异常", () {
            throw Exception("Test throw one exception!!!");
          }),
          TextEntranceWidget.createEntrance(context, "异步异常", () {
            // 以下这种异步的异常，虽然使用try-catch，但是是无法捕获的
            try {
              Future.delayed(Duration(seconds: 1)).then(
                      (e) => Future.error("Test throw one async exception!!!"));
            } catch (e) {
              print(e);
            }
          }),
        ],
      )
    ],
  );
}
