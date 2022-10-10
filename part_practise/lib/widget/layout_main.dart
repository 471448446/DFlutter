
import 'package:flutter/cupertino.dart';
import 'package:part_practise/utils/ui.dart';
import 'package:part_practise/widget/layout/constranedbox_min.dart';


/// 一些UI控件的演示
class LayoutDemoWidget extends StatelessWidget {
  const LayoutDemoWidget({super.key});

  @override
  Widget build(BuildContext context) => Column(children: [
    const TextTitleWidget("Layout"),
    Wrap(
        spacing: 1.0, // 主轴(水平)方向间距
        runSpacing: 1.0, // 纵轴（垂直）方向间距
        alignment: WrapAlignment.start, //沿主轴方向居中
        children: [
          TextEntranceWidget.createEntranceAndWait(
              context, "ConstrainedBox", ConstrainedBoxRoutePage()),
        ])
  ]);
}
