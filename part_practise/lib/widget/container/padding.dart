import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:part_practise/utils/ui.dart';
/// 添加一个间距，这里要转变一个思路，在flutter中是通过包裹一个元素来实现另外的功能，
/// 不不像在Android中，每个view都可以设置padding，margin。flutter中是分开的，view是专门的widget，间距又是另外的widget，需要时，
/// 要借助另外一个或者多个组件来实现功能（其实这就是flutter或者dart中的一种思想，优先用组合而非继承）。
/// 通过组合widget来实现功能，checkbox的状态变化、progressbar中的修改大小
class PaddingRoutePage extends SimplePageRoute {
  PaddingRoutePage({super.key}) : super('Padding');

  @override
  Widget pageBody() => Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              color: Colors.red,
              height: 20,
              // 这里不用指定宽，因为Colum默认是填充整个宽,可以调整mainAxisSize改变这个效果
            ),
          )
        ],
      );
}
