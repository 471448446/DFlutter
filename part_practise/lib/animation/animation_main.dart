import 'package:flutter/cupertino.dart';
import 'package:part_practise/animation/AnimationTest.dart';
import 'package:part_practise/utils/ui.dart';

/// 动画
class AnimationDemoWidget extends StatelessWidget {
  const AnimationDemoWidget({super.key});

  @override
  Widget build(BuildContext context) => Column(children: [
    const TextTitleWidget("滑动事件和通知"),
    Wrap(
        spacing: 1.0, // 主轴(水平)方向间距
        runSpacing: 1.0, // 纵轴（垂直）方向间距
        alignment: WrapAlignment.start, //沿主轴方向居中
        children: [
          TextEntranceWidget.createEntranceAndWait(
              context, "动画", AnimationRoutePage()),
        ])
  ]);
}
