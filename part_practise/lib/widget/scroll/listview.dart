import 'package:flutter/material.dart';
import 'package:part_practise/utils/ui.dart';

/// 这种方式适合只有少量的子组件数量已知且比较少的情况，反之则应该使用ListView.builder 按需动态构建列表项。
class ListView1RoutePage extends SimplePageRoute {
  ListView1RoutePage({super.key}) : super('ListView有明确的子元素的时候');

  /// 这里无法剧中[pageBody0]
  /// 所以使用了Center，这是从父布局的方式来处理 [pageBody1]
  /// 也可以从内部 [pageBody2]
  @override
  Widget pageBody(BuildContext context) => ListView(
        padding: const EdgeInsets.all(10),
        children: const [
          Text('I\'m dedicating every day to you'),
          Text('Domestic life was never quite my style'),
          Text('When you smile, you knock me out, I fall apart'),
          Text('And I thought I was so smart'),
        ],
      );
}
