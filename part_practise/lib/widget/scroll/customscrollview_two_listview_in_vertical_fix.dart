import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:part_practise/utils/ui.dart';

/// 垂直方向上两个listview，按照经验，必须要固定每个的高度，不然无法展示
/// 这里想说的是，让两个ListView连起来
/// 修改方案
class TwoListViewInVerticalFixRoutePage extends SimplePageRoute {
  TwoListViewInVerticalFixRoutePage({super.key}) : super('垂直方向两个ListView修改方案');

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
    return CustomScrollView(
      slivers: [
        listView,
        const SliverToBoxAdapter(
          child: Divider(
            color: Colors.red,
          ),
        ),
        // 只能是sliver
        // Divider(color: Colors.red,),
        listView,
      ],
    );
  }

  @override
  Widget pageBody() => buildTwoSliverList();
}
