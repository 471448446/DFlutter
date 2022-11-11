import 'package:flutter/material.dart';
import 'package:part_practise/motionevent/gesturedetector_click.dart';
import 'package:part_practise/motionevent/gesturedetector_nest.dart';
import 'package:part_practise/motionevent/gesturedetector_scale.dart';
import 'package:part_practise/motionevent/gesturedetector_scroll.dart';
import 'package:part_practise/motionevent/listener_pointer.dart';
import 'package:part_practise/motionevent/notification_listen.dart';
import 'package:part_practise/motionevent/notificationroute_custom.dart';
import 'package:part_practise/utils/ui.dart';

import 'gesturerecognizer_hello.dart';

/// 滑动事件
class MotionEventDemoWidget extends StatelessWidget {
  const MotionEventDemoWidget({super.key});

  @override
  Widget build(BuildContext context) => Column(children: [
        const TextTitleWidget("滑动事件和通知"),
        Wrap(
            spacing: 1.0, // 主轴(水平)方向间距
            runSpacing: 1.0, // 纵轴（垂直）方向间距
            alignment: WrapAlignment.start, //沿主轴方向居中
            children: [
              TextEntranceWidget.createEntranceAndWait(
                  context, " 触摸事件", PrintOffsetRoutePage()),
              TextEntranceWidget.createEntranceAndWait(context,
                  "GestureDetector点击", GestureDetectorClickRoutePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, "GestureDetector嵌套", GestureDetectorNestRoutePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, "GestureDetector滑动", GestureDetectorMoveRoutePage()),
              TextEntranceWidget.createEntranceAndWait(context,
                  "GestureDetector缩放", GestureDetectorScaleRoutePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, "GestureRecognizer使用", GestureRecognizerRoutePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, "Notification监听", NotificationListenRoutePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, "Notification自定义", NotificationCustomRoutePage()),
            ])
      ]);
}
