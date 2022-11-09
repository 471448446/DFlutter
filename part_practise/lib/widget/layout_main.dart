import 'package:flutter/cupertino.dart';
import 'package:part_practise/utils/ui.dart';
import 'package:part_practise/widget/layout/align.dart';
import 'package:part_practise/widget/layout/constranedbox_min.dart';
import 'package:part_practise/widget/layout/flexlayout.dart';
import 'package:part_practise/widget/layout/flowlayout.dart';
import 'package:part_practise/widget/layout/layout_demo.dart';
import 'package:part_practise/widget/layout/layoutbuilder.dart';
import 'package:part_practise/widget/layout/linear_nest_colum_fix.dart';
import 'package:part_practise/widget/layout/linear_nest_row.dart';
import 'package:part_practise/widget/layout/linear_row.dart';
import 'package:part_practise/widget/layout/linear_nest_colum.dart';
import 'package:part_practise/widget/layout/stack_layout.dart';
import 'package:part_practise/widget/layout/unconstranedbox_min.dart';
import 'package:part_practise/widget/layout/wraplayout.dart';

/// 一些布局widget
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
                  context, "约束布局ConstrainedBox", ConstrainedBoxRoutePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, "约束布局UnconstrainedBox", UnconstrainedBoxRoutePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, "线性布局Row", RowDemoWidget()),
              TextEntranceWidget.createEntranceAndWait(
                  context, "线性布局ColumNested", ColumNestRoutePagetePage()),
              TextEntranceWidget.createEntranceAndWait(context,
                  "线性布局ColumNested尽可能大", ColumNestFixRoutePagetePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, "线性布局RowNested", RowNestRoutePagetePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, "弹性布局FlexLayout", FlexLayoutRoutePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, "流式布局Wrap", WrapLayoutRoutePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, "流式布局Flow", FlowRoutePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, "层叠布局Stack", StackLayoutRoutePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, "对齐布局Align", AlignLayoutRoutePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, "LayoutBuilder", LayoutBuilderRoute()),
              TextEntranceWidget.createEntranceAndWait(
                  context, "布局Demo", LayoutDemoRoutePage()),
            ])
      ]);
}
