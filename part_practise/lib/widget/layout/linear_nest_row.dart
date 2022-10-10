import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:part_practise/utils/ui.dart';

/// 嵌套
///
class RowNestRoutePagetePage extends SimplePageRoute {
  RowNestRoutePagetePage() : super('colum嵌套colum');

  @override
  Widget pageBody() => Container(
        color: Colors.green,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max, //有效，外层Colum高度为整个屏幕
            children: <Widget>[
              Container(
                color: Colors.red,
                child: Row(
                  mainAxisSize: MainAxisSize.max, //无效，内层Colum高度为实际高度
                  children: const <Widget>[
                    Text("hello world "),
                    Text("I am Jack "),
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
