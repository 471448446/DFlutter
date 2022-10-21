import 'package:flutter/material.dart';
import 'package:part_practise/utils/ui.dart';

class NotificationListenRoutePage extends SimplePageRoute {
  NotificationListenRoutePage({super.key}) : super("监听列表滑动通知");

  @override
  Widget pageBody(BuildContext context) => NotificationListener(
        onNotification: (notify) {
          switch (notify.runtimeType) {
            case ScrollStartNotification:
              print("开始滚动");
              break;
            case ScrollUpdateNotification:
              print("正在滚动");
              break;
            case ScrollEndNotification:
              print("滚动停止");
              break;
            case OverscrollNotification:
              print("滚动到边界");
              break;
          }
          // ture 不雅网上冒泡了，既消耗这个事件
          return true;
        },
        child: ListView.builder(
            itemCount: 20,
            itemExtent: 50,
            itemBuilder: (context, index) => Center(child: Text("$index"),)),
      );
}
