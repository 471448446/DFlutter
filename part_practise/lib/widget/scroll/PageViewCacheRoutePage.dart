import 'package:flutter/material.dart';
import 'package:part_practise/utils/ui.dart';

// 缓存每个页面
// 查看控制台输出，只会打印一次相关的页面build信息
class PageViewCacheRoutePage extends SimplePageRoute {
  PageViewCacheRoutePage({super.key}) : super('like ViewPager');

  @override
  Widget pageBody() => PageView(
        scrollDirection: Axis.horizontal,
        children: [_Page(0), _Page(1), _Page(2), _Page(3), _Page(4), _Page(5)],
      );
}

class _Page extends StatefulWidget {
  int index;

  _Page(this.index);

  @override
  State<StatefulWidget> createState() => _PageState(index);
}

class _PageState extends State<_Page> with AutomaticKeepAliveClientMixin {
  int index;

  _PageState(this.index);

  @override
  Widget build(BuildContext context) {
    super.build(
        context); // 这里变成了AutomaticKeepAliveClientMixin的 build方法了，所以需要调研super
    return LayoutLogPrint(
        tag: "PageView$index",
        child: Center(
            child: Text('$index',
                style: const TextStyle(color: Colors.red, fontSize: 20),
                textScaleFactor: 2)));
  }

  @override
  bool get wantKeepAlive => true;
}
