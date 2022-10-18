import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:part_practise/utils/ui.dart';

class ScrollControllerNotificationListenerRoutePage extends SimplePageRoute {
  ScrollControllerNotificationListenerRoutePage({super.key}) : super('滚动控制');

  @override
  Widget pageBody(BuildContext context) => _Page();
}

class _Page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageState();
}

class _PageState extends State<_Page> {
  var percent = "0%";

  @override
  Widget build(BuildContext context) => NotificationListener(
      onNotification: (ScrollNotification notification) {
        double progress =
            notification.metrics.pixels / notification.metrics.maxScrollExtent;
        //重新构建
        setState(() {
          percent = "${(progress * 100).toInt()}%";
        });
        print("BottomEdge: ${notification.metrics.extentAfter == 0}");
        return false;
      },
      child: Stack(
        children: [
          ListView.separated(
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  '$index',
                  textScaleFactor: 2,
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                color: Colors.blue,
              );
            },
            itemCount: 50,
          ),
          Align(
              alignment: Alignment.center,
              //              CircleAvatar()
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      border: Border.all(color: Colors.red),
                      borderRadius: BorderRadius.circular(100)),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(percent),
                  )))
        ],
      ));
}
