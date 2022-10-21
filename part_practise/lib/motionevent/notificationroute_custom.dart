import 'package:flutter/material.dart';
import 'package:part_practise/utils/ui.dart';

class NotificationCustomRoutePage extends SimplePageRoute {
  NotificationCustomRoutePage({super.key}) : super("自定义通知");

  @override
  Widget pageBody(BuildContext context) {
    /// 这里在最外层加了一个通知接收器，进行前台，
    /// 在NotificationRouteState里面的通知onNotification如果返回true，这里收不到消息了
    return NotificationListener<MyNotification>(
        onNotification: (notification) {
          print(notification.msg);
          return false;
        },
        child: _Pages());
  }
}

class _Pages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NotificationRouteState();
  }
}

class NotificationRouteState extends State<_Pages> {
  String _msg = "";

  @override
  Widget build(BuildContext context) {
    //监听通知
    return NotificationListener<MyNotification>(
      onNotification: (notification) {
        setState(() {
          _msg += "${notification.msg}  ";
        });
        return false;
      },
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            /// 这个按钮是无效的因为，context是Widget build(BuildContext context)里面的。
            /// NotificationRouteState里面的通知接收者，是收不到消息的，只有往上冒泡，到最外层，日志还是可以打印的
            ElevatedButton(
              onPressed: () => MyNotification("Hi").dispatch(context),
              child: const Text("Send Notification Must Fail"),
            ),
            Builder(
              builder: (context) {
                return ElevatedButton(
                  //按钮点击时分发通知
                  onPressed: () => MyNotification("Hi").dispatch(context),
                  child: const Text("Send Notification"),
                );
              },
            ),
            Text(_msg)
          ],
        ),
      ),
    );
  }
}

class MyNotification extends Notification {
  MyNotification(this.msg);

  final String msg;
}
