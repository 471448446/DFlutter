import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:part_practise/utils/ui.dart';

/// https://book.flutterchina.club/chapter3/radio_and_checkbox.html
/// 没有一个单独的控件来实现CheckBox，需要借助其他的来组合
class CheckBoxRoutePage extends SimplePageRoute {
  CheckBoxRoutePage({super.key}) : super('CheckBox');

  @override
  Widget pageBody(BuildContext context) => _CheckBoxWidget();
}

class _CheckBoxWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<_CheckBoxWidget> {
  bool _switch = true;
  bool _check = true;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(
            children: [
              Switch(
                  value: _switch, //当前状态
                  onChanged: (bool change) {
                    setState(() {
                      _switch = change;
                    });
                  }),
              Text(_switch ? "开" : "关")
            ],
          ),
          Row(
            children: [
              Checkbox(
                  value: _check,
                  activeColor: Colors.red, //选中时的颜色
                  // 居然是可空的
                  onChanged: (bool? change) {
                    setState(() {
                      _check = change!;
                    });
                  }),
              Text(_check ? "是" : "否")
            ],
          )
        ],
      );
}
