import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:part_practise/utils/ui.dart';

class ScrollController1RoutePage extends SimplePageRoute {
  ScrollController1RoutePage({super.key}) : super('滚动控制');

  @override
  Widget pageBody() => _Page();
}

class _Page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageState();
}

class _PageState extends State<_Page> {
  var showBackTop = false;
  var scroller = ScrollController();

  @override
  void initState() {
    super.initState();
    scroller.addListener(() {
      print(scroller.offset);
      var result = scroller.offset > 1000;
      if (showBackTop != result) {
        setState(() {
          showBackTop = result;
        });
      }
    });
  }

  @override
  void deactivate() {
    super.deactivate();
    // 因为前面设置的Listener
    scroller.dispose();
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          ListView.separated(
            controller: scroller,
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
            itemCount: 1000,
          ),
          Visibility(
            visible: showBackTop,
            child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: FloatingActionButton(
                      onPressed: () {
                        // 直接跳
                        // scroller.jumpTo(0);
                        // 使用动画
                        scroller.animateTo(0,
                            duration: const Duration(seconds: 2),
                            curve: Curves.ease);
                      },
                      child: const Icon(Icons.arrow_upward)),
                )),
          )
        ],
      );
}
