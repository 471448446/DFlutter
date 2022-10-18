import 'package:flutter/material.dart';
import 'package:part_practise/utils/ui.dart';

/// PageView更像是Android中的ViewPage。可以设置横行、纵向的滑动方式
/// TabBarView用于横向的滑动，配合TabBar来展示不同的tab
class PageViewRoutePage extends SimplePageRoute {
  PageViewRoutePage({super.key}) : super('like ViewPager');

  @override
  Widget pageBody(BuildContext context) => PageView(
        scrollDirection: Axis.horizontal,
        allowImplicitScrolling: true, // 该参数，只能缓存前后一个页面
        children: [_Page(0), _Page(1), _Page(2), _Page(3), _Page(4), _Page(5)],
      );
}

class _Page extends StatefulWidget {
  int index;

  _Page(this.index);

  @override
  State<StatefulWidget> createState() => _PageState(index);
}

class _PageState extends State<_Page> {
  int index;

  _PageState(this.index);

  @override
  Widget build(BuildContext context) {
    // 每次展示的时候，还是会build一次
    return LayoutLogPrint(
        tag: "PageView$index",
        child: Center(
            child: Text('$index',
                style: const TextStyle(color: Colors.red, fontSize: 20),
                textScaleFactor: 2)));
  }
}
