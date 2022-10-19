import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:part_practise/utils/ui.dart';

///另外一种监听变化的方案
class ValueListenableRoutePage extends SimplePageRoute {
  ValueListenableRoutePage({super.key}) : super("ValueListenable 监听变化-公共父级");

  @override
  Widget pageBody(BuildContext context) => _Pages();
}

class _Pages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PagesState();
}

class _PagesState extends State<_Pages> {
  // 定义一个ValueNotifier，当数字变化时会通知 ValueListenableBuilder
  final ValueNotifier<int> valueNotifier = ValueNotifier(0);
  var clickTimes = 0;

  @override
  Widget build(BuildContext context) {
    // 添加 + 按钮不会触发整个 ValueListenableRoute 组件的 build
    print('build StatefulWidget');
    // 这里放在了最顶层的父类中，所以交父级！！！
    return ValueListenableBuilder<int>(
        valueListenable: valueNotifier,
        builder: (BuildContext context, int value, Widget? child) {
          print('build ValueListenableBuilder');
          return Center(
            child: Column(
              children: [
                Text("$clickTimes"),
                Text(
                  "$value",
                  textScaleFactor: 2,
                ),
                // 使用ValueListenable ，触发 ValueListenableBuilder 重新构建
                ElevatedButton(
                    onPressed: () {
                      valueNotifier.value++;
                      // setState(() {
                      //   clickTimes++;
                      // });
                    },
                    child: const Text('使用ValueListenable更新')),
                // 使用setState更新会重绘，进而刷新数据
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        clickTimes++;
                      });
                    },
                    child: const Text('使用setState更新'))
              ],
            ),
          );
        });
  }
}
