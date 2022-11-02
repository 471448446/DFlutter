import 'package:flutter/cupertino.dart';
import 'package:part_practise/customwidget/way1_from_combine.dart';
import 'package:part_practise/customwidget/way1_from_combine2.dart';
import 'package:part_practise/utils/ui.dart';

/// 自定义组件
class CustomDefineWidgetDemoWidget extends StatelessWidget {
  const CustomDefineWidgetDemoWidget({super.key});

  @override
  Widget build(BuildContext context) => Column(children: [
        const TextTitleWidget("自定义组件"),
        Wrap(
            spacing: 1.0, // 主轴(水平)方向间距
            runSpacing: 1.0, // 纵轴（垂直）方向间距
            alignment: WrapAlignment.start, //沿主轴方向居中
            children: [
              TextEntranceWidget.createEntranceAndWait(
                  context, "组合", CustomWidgetRoutePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, "组合2", CustomWidgetFromCombineRoutePage()),

              ///todo 更多
            ])
      ]);
}
