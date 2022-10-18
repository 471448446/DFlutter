import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:part_practise/utils/ui.dart';

/// 垂直方向上两个listview，按照经验，必须要固定每个的高度，不然无法展示
/// 这里想说的是，让两个ListView连起来

class TwoListViewInVerticalRoutePage extends SimplePageRoute {
  TwoListViewInVerticalRoutePage({super.key}):super('垂直方向两个ListView');

  var listView = ListView.builder(
    itemCount: 20,
    itemBuilder: (_, index) => ListTile(title: Text('$index')),
  );

  @override
  Widget pageBody(BuildContext context) =>
      Column(
        children: [
          Expanded(child: listView),
          Divider(color: Colors.red),
          Expanded(child: listView),
        ],
      );

}