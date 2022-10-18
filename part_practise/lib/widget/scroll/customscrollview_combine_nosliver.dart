import 'package:flutter/material.dart';
import 'package:part_practise/utils/ui.dart';

/// CustomScrollView要求子组件必须时Sliver，这里借助其他方法实现非sliver的组件添加进来
class CustomScrollViewCombineNoSliver extends SimplePageRoute {
  CustomScrollViewCombineNoSliver({super.key}) : super('组合非Sliver的组件');

  Widget buildTwoSliverList() {
    // SliverFixedExtentList 是一个 Sliver，它可以生成高度相同的列表项。
    // 再次提醒，如果列表项高度相同，我们应该优先使用SliverFixedExtentList
    // 和 SliverPrototypeExtentList，如果不同，使用 SliverList.
    var listView = SliverFixedExtentList(
      itemExtent: 56, //列表项高度固定
      delegate: SliverChildBuilderDelegate(
        (_, index) => ListTile(title: Text('$index')),
        childCount: 10,
      ),
    );
    // 使用
    return listView;
  }

  @override
  Widget pageBody(BuildContext context) => CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 300,
              child: PageView(
                children: const [
                  Center(
                    child: Text("1"),
                  ),
                  Center(
                    child: Text("2"),
                  )
                ],
              ),
            ),
          ),
          buildTwoSliverList(),
        ],
      );
}
