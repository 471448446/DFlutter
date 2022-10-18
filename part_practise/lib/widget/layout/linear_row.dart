import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:part_practise/utils/ui.dart';

class RowDemoWidget extends SimplePageRoute {
  RowDemoWidget() : super("Row");

  samBox(MaterialColor color) => SizedBox(
      width: 50,
      height: 50,
      child: DecoratedBox(
        decoration: BoxDecoration(color: color),
      ));

  @override
  Widget pageBody(BuildContext context) {
    return Column(
      children: [
        const Text('主轴对其方式，这里Row主轴就是水平的X轴'),
        Row(
          mainAxisAlignment: MainAxisAlignment.start, // 默认就是start
          children: [
            samBox(Colors.red),
            samBox(Colors.blue),
            samBox(Colors.teal),
            samBox(Colors.amber)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            samBox(Colors.red),
            samBox(Colors.blue),
            samBox(Colors.teal),
            samBox(Colors.amber)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            samBox(Colors.red),
            samBox(Colors.blue),
            samBox(Colors.teal),
            samBox(Colors.amber)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            samBox(Colors.red),
            samBox(Colors.blue),
            samBox(Colors.teal),
            samBox(Colors.amber)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            samBox(Colors.red),
            samBox(Colors.blue),
            samBox(Colors.teal),
            samBox(Colors.amber)
          ],
        ),
        const Text('mainAxisSize区分'),
        Row(
          mainAxisAlignment: MainAxisAlignment.start, // 默认就是start
          mainAxisSize: MainAxisSize.max, //默认就是这个，尽可能的大，row是水平的，那么会填充屏幕的宽度
          children: [
            samBox(Colors.red),
            samBox(Colors.blue),
            samBox(Colors.teal),
            samBox(Colors.amber)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          // 默认就是start
          mainAxisSize: MainAxisSize.min,
          // 最小值，因为colum这里没有设置纵轴（既水平方向的）对其方式，所以这一个是剧中展示的
          children: [
            samBox(Colors.red),
            samBox(Colors.blue),
            samBox(Colors.teal),
            samBox(Colors.amber)
          ],
        ),
        const Text('纵轴对其方式'),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start, // 默认值是center，这里修改了
          verticalDirection: VerticalDirection.down, // 默认从上到下
          children: const <Widget>[
            Text(
              " hello world ",
              style: TextStyle(fontSize: 30.0),
            ),
            Text(" I am Jack "),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start, // 默认值是center，这里修改了
          verticalDirection: VerticalDirection.up, // 设置为从下到上
          children: const <Widget>[
            Text(
              " hello world ",
              style: TextStyle(fontSize: 30.0),
            ),
            Text(" I am Jack "),
          ],
        ),
      ],
    );
  }
}
