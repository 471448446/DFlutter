import 'package:flutter/material.dart';
import 'package:part_practise/up/layout/CustomCenter.dart';
import 'package:part_practise/up/orientation/OrientationRotePage.dart';
import 'package:part_practise/up/orientation/OrientationSetRoutePage.dart';
import 'package:part_practise/utils/ui.dart';

/// 更多原理
class UpMoreDemoWidget extends StatelessWidget {
  const UpMoreDemoWidget({super.key});

  @override
  Widget build(BuildContext context) => Column(children: [
        const TextTitleWidget("More"),
        Wrap(
            spacing: 1.0, // 主轴(水平)方向间距
            runSpacing: 1.0, // 纵轴（垂直）方向间距
            alignment: WrapAlignment.start, //沿主轴方向居中
            children: [
              TextEntranceWidget.createEntranceAndWait(
                  context, "单个节点布局", CustomSingleWidgetRoutePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, "屏幕旋转", OrientationRoutePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, "强制横屏", OrientationSetRoutePage()),
            ])
      ]);
}
