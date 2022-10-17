import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:part_practise/utils/ui.dart';

/// 书上的demo
/// 预期的效果是 SliverList 和 下面的 ListView 的滑动能够统一（而不是在下面ListView 上滑动时只有ListView响应滑动），整个页面在垂直方向是一个整体
/// 两个List不一样。跟CustomScrollView不一样，他里面是两个SliverList。
class NestedScrollViewTest extends StatelessWidget {
  // NestedScrollViewTest({super.key}):super('NestedScrollView使用');

  @override
  Widget build(BuildContext context) => Material(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            // 返回一个 Sliver 数组给外部可滚动组件。
            return <Widget>[
              SliverAppBar(
                title: const Text('嵌套ListView'),
                pinned: true, // 固定在顶部
                forceElevated: innerBoxIsScrolled,
              ),
              buildSliverList(5), //构建一个 sliverList
            ];
          },
          body: ListView.builder(
            padding: const EdgeInsets.all(8),
            physics: const ClampingScrollPhysics(), //重要
            itemCount: 30,
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 50,
                child: Center(child: Text('Item $index')),
              );
            },
          ),
        ),
      );
}

buildSliverList(int count) {
  var listView = SliverFixedExtentList(
    itemExtent: 56, //列表项高度固定
    delegate: SliverChildBuilderDelegate(
      (_, index) => ListTile(title: Text('$index')),
      childCount: count,
    ),
  );
  return listView;
}
