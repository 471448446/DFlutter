import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:part_practise/utils/ui.dart';

/// 简单打印一下触摸事件
class PrintOffsetRoutePage extends SimplePageRoute {
  PrintOffsetRoutePage({super.key}) : super('滑动检查间距');

  @override
  Widget pageBody(BuildContext context) => _Pages();
}

class _Pages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PagesState();
}

class _PagesState extends State<_Pages> {
  PointerEvent? events;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Listener(
            onPointerDown: (event) {
              setState(() {
                events = event;
              });
            },
            onPointerMove: (event) => setState(() => events = event),
            onPointerCancel: (event) => setState(() => events = event),
            child: Container(
              width: 300,
              height: 150,
              decoration: const BoxDecoration(color: Colors.green),
              child: Align(
                alignment: Alignment.center,
                // 相对父容器的间距
                child: Text(
                    '矩形大小300*150\n父间距${events?.localPosition}\n全局距${events?.position}'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Listener(
              child: AbsorbPointer(
                child: Listener(
                  child: Container(
                    color: Colors.red,
                    width: 200.0,
                    height: 100.0,
                  ),
                  // 不会打印，因为AbsorbPointer屏蔽了子组件接受事件
                  onPointerDown: (event) => print("in"),
                ),
              ),
              onPointerDown: (event) => print("up"),
            ),
          )
        ],
      );
}
