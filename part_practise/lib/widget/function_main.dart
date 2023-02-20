import 'package:flutter/material.dart';
import 'package:part_practise/utils/ui.dart';
import 'package:part_practise/widget/function/alert_dialog.dart';
import 'package:part_practise/widget/function/future_builder.dart';
import 'package:part_practise/widget/function/inheritedwidget.dart';
import 'package:part_practise/widget/function/like_provider.dart';
import 'package:part_practise/widget/function/value_listenable.dart';
import 'package:part_practise/widget/function/value_listenable2.dart';

import 'function/stream_builder.dart';

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
              TextEntranceWidget.createEntranceAndWait(
                  context, "ValueListenable", ValueListenableRoutePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, "ValueListenable2", ValueListenable2RoutePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, "异步刷新FutureBuilder", FutureBuilderRoutePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, "异步刷新StreamBuilder", StreamBuilderRoutePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, "AlertDialog", AlertDialogRoutePage()),
            ])
      ]);
}
