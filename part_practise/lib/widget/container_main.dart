import 'package:flutter/cupertino.dart';
import 'package:part_practise/utils/ui.dart';
import 'package:part_practise/widget/container/scaffold2.dart';
import 'package:part_practise/widget/container/clip.dart';
import 'package:part_practise/widget/container/container.dart';
import 'package:part_practise/widget/container/decorated.dart';
import 'package:part_practise/widget/container/fitbox.dart';
import 'package:part_practise/widget/container/fitbox2.dart';
import 'package:part_practise/widget/container/padding.dart';
import 'package:part_practise/widget/container/scaffold.dart';
import 'package:part_practise/widget/container/transform.dart';

/// 容器类的Widget
class ContainerDemoWidget extends StatelessWidget {
  const ContainerDemoWidget({super.key});

  @override
  Widget build(BuildContext context) => Column(children: [
        const TextTitleWidget("Container"),
        Wrap(
            spacing: 1.0, // 主轴(水平)方向间距
            runSpacing: 1.0, // 纵轴（垂直）方向间距
            alignment: WrapAlignment.start, //沿主轴方向居中
            children: [
              TextEntranceWidget.createEntranceAndWait(
                  context, "Padding", PaddingRoutePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, "DecoratedBox", DecoratedBoxRoutePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, "Transform", TransformRoutePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, "Container", ContainerRoutePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, "Clip", ClipRoutePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, "FitBox", FitBoxRoutePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, "FitBox2", FitBox2RoutePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, " Scaffold", const ScaffoldRoutePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, " Scaffold2", const Scaffold2RoutePage()),
            ])
      ]);
}
