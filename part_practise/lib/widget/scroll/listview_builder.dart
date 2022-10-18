import 'package:flutter/material.dart';
import 'package:part_practise/utils/ui.dart';

class ListView2RoutePage extends SimplePageRoute {
  ListView2RoutePage({super.key}) : super('ListView.builder');

  /// 这里无法剧中[pageBody0]
  /// 所以使用了Center，这是从父布局的方式来处理 [pageBody1]
  /// 也可以从内部 [pageBody2]
  @override
  Widget pageBody(BuildContext context) => ListView.builder(
      itemCount: 20, // 限制个数，否正是无限
      itemExtent: 50.0, //强制每个item的高度为50.0,
      itemBuilder: (context, index) {
        return ListTile(title: Text('$index'));
      });
}
