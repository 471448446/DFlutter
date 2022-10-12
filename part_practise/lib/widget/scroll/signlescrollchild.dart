import 'package:flutter/material.dart';
import 'package:part_practise/utils/ui.dart';

/// SingleChildScrollView没有按需加载的功能！
class SingleScrollRoutePage extends SimplePageRoute {
  SingleScrollRoutePage({super.key}) : super('SingleScrollChild');

  /// 这里无法剧中[pageBody0]
  /// 所以使用了Center，这是从父布局的方式来处理 [pageBody1]
  /// 也可以从内部 [pageBody2]
  @override
  Widget pageBody() => pageBody2();

  Widget pageBody0() => Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                .split("")
                .map((e) => createText(e))
                .toList(),
          ),
        ),
      );

  // 外部的父组件解决
  Widget pageBody1() => Scrollbar(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                  .split("")
                  .map((e) => createText(e))
                  .toList(),
            ),
          ),
        ),
      );

  Text createText(String alpha) {
    return Text(
      alpha,
      textScaleFactor: 2, // 缩放为原来的两倍
      style: const TextStyle(color: Colors.black, fontSize: 20),
    );
  }

  // 从内部解决
  Widget pageBody2() => LayoutBuilder(builder: (context, constrains) {
        return Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                  .split("")
                  .map((e) => ConstrainedBox(
                        // 这个是前面 FittedBox 的一个思路
                        constraints: constrains.copyWith(
                            minWidth: constrains.maxWidth,
                            maxWidth: double.infinity),
                        child: Text(
                          e,
                          textAlign: TextAlign.center,
                          textScaleFactor: 2, // 缩放为原来的两倍
                          style: const TextStyle(
                              color: Colors.black, fontSize: 20),
                        ),
                      ))
                  .toList(),
            ),
          ),
        );
      });
}
