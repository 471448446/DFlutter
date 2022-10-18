import 'package:flutter/material.dart';
import 'package:part_practise/utils/ui.dart';
import 'package:part_practise/widget/function/inheritedwidget.dart';
import 'package:part_practise/widget/function/like_provider.dart';

/// 一些常用功能组件
class FunctionDemoWidget extends StatelessWidget {
  const FunctionDemoWidget({super.key});

  @override
  Widget build(BuildContext context) => Column(children: [
        const TextTitleWidget("常用功能"),
        Wrap(
            spacing: 1.0, // 主轴(水平)方向间距
            runSpacing: 1.0, // 纵轴（垂直）方向间距
            alignment: WrapAlignment.start, //沿主轴方向居中
            children: [
              TextEntranceWidget.createEntranceAndWait(
                  context, "共享数据", InheritedWidgetRoutePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, "共享数据Provider", LikeProviderRoutePage()),
            ])
      ]);
}
