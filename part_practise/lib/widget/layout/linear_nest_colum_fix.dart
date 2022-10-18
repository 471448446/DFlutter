import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:part_practise/utils/ui.dart';

/// 嵌套后，最里面的大小就是最小值，而不是按照主轴的最大值来了,这里使用Expand来让最里面的尽可能大
///
class ColumNestFixRoutePagetePage extends SimplePageRoute {
  ColumNestFixRoutePagetePage() : super('row嵌套row');

  @override
  Widget pageBody(BuildContext context) => Container(
        color: Colors.green,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max, //有效，外层Colum高度为整个屏幕
            children: <Widget>[
              Expanded(child: Container(
                color: Colors.red,
                child: Column(
                  mainAxisSize: MainAxisSize.max, //无效，内层Colum高度为实际高度
                  children: const <Widget>[
                    Text("hello world "),
                    Text("I am Jack "),
                  ],
                ),
              ))
            ],
          ),
        ),
      );
}
