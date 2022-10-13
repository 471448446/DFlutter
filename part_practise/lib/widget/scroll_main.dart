import 'package:flutter/material.dart';
import 'package:part_practise/utils/ui.dart';
import 'package:part_practise/widget/scroll/animatedlist.dart';
import 'package:part_practise/widget/scroll/listview.dart';
import 'package:part_practise/widget/scroll/listview_builder.dart';
import 'package:part_practise/widget/scroll/listview_loadmore.dart';
import 'package:part_practise/widget/scroll/listview_separator.dart';
import 'package:part_practise/widget/scroll/scroll_controller.dart';
import 'package:part_practise/widget/scroll/scroll_listener.dart';
import 'package:part_practise/widget/scroll/signlescrollchild.dart';

class ScrollDemoWidget extends StatelessWidget {
  const ScrollDemoWidget({super.key});

  @override
  Widget build(BuildContext context) => Column(children: [
        const TextTitleWidget("Scroll"),
        Wrap(
            spacing: 1.0, // 主轴(水平)方向间距
            runSpacing: 1.0, // 纵轴（垂直）方向间距
            alignment: WrapAlignment.start, //沿主轴方向居中
            children: [
              TextEntranceWidget.createEntranceAndWait(
                  context, "SingleChildScrollView", SingleScrollRoutePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, "ListView1", ListView1RoutePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, "ListView.builder()", ListView2RoutePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, "ListView.separator()", ListView3RoutePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, "ListView loadMore)", ListViewLoadMoreRoutePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, "ScrollController", ScrollController1RoutePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context,
                  "ScrollNotificationListener",
                  ScrollControllerNotificationListenerRoutePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, "AnimatedList", AnimatedListeRoutePage()),
            ])
      ]);
}
