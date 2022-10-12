import 'package:flutter/material.dart';
import 'package:part_practise/utils/ui.dart';

class ListView3RoutePage extends SimplePageRoute {
  final divider1 = const Divider(
    color: Colors.red,
  );
  final divider2 = const Divider(
    color: Colors.blue,
  );

  ListView3RoutePage({super.key}) : super('ListView.builder');

  /// 这里无法剧中[pageBody0]
  /// 所以使用了Center，这是从父布局的方式来处理 [pageBody1]
  /// 也可以从内部 [pageBody2]
  @override
  Widget pageBody() => ListView.separated(
      itemCount: 20, // 限制个数，否正是无限
      separatorBuilder: (BuildContext context, int index) {
        return index % 2 == 0 ? divider1 : divider2;
      },
      itemBuilder: (context, index) {
        return ListTile(title: Text('$index'));
      });
}
