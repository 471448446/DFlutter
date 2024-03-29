import 'package:flutter/material.dart';
import 'package:part_practise/utils/ui.dart';
import 'package:part_practise/widget/function/future_builder.dart';
import 'package:part_practise/widget/future/future_combine.dart';
import 'package:part_practise/widget/future/future_create.dart';
import 'package:part_practise/widget/scroll/PageViewCacheRoutePage.dart';
import 'package:part_practise/widget/scroll/PageViewRoutePage.dart';
import 'package:part_practise/widget/scroll/animatedlist.dart';
import 'package:part_practise/widget/scroll/customscrollview_combine_nosliver.dart';
import 'package:part_practise/widget/scroll/customscrollview_demo.dart';
import 'package:part_practise/widget/scroll/gridlayout.dart';
import 'package:part_practise/widget/scroll/listview.dart';
import 'package:part_practise/widget/scroll/listview_builder.dart';
import 'package:part_practise/widget/scroll/listview_loadmore.dart';
import 'package:part_practise/widget/scroll/listview_separator.dart';
import 'package:part_practise/widget/scroll/nestedscrollview_test.dart';
import 'package:part_practise/widget/scroll/pageview_bottombar.dart';
import 'package:part_practise/widget/scroll/scroll_controller.dart';
import 'package:part_practise/widget/scroll/scroll_listener.dart';
import 'package:part_practise/widget/scroll/signlescrollchild.dart';
import 'package:part_practise/widget/scroll/tabbar.dart';
import 'package:part_practise/widget/scroll/customscrollview_two_listview_in_vertical.dart';
import 'package:part_practise/widget/scroll/customscrollview_two_listview_in_vertical_fix.dart';

class FutureWidget extends StatelessWidget {
  const FutureWidget({super.key});

  @override
  Widget build(BuildContext context) => Column(children: [
        const TextTitleWidget("Future"),
        Wrap(
            spacing: 1.0, // 主轴(水平)方向间距
            runSpacing: 1.0, // 纵轴（垂直）方向间距
            alignment: WrapAlignment.start, //沿主轴方向居中
            children: [
              TextEntranceWidget.createEntranceAndWait(
                context,
                "Future创建",
                FutureCreateRoutePage(),
              ),
              TextEntranceWidget.createEntranceAndWait(
                context,
                "Future 合并多个任务",
                FutureCombine(),
              ),
            ])
      ]);
}
