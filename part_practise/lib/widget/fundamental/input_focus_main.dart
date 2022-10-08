import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:part_practise/utils/ui.dart';

/// 移动焦点
/// 焦点可以通过FocusNode和FocusScopeNode来控制，默认情况下，焦点由FocusScope来管理，它代表焦点控制范围，
/// 可以在这个范围内可以通过FocusScopeNode在输入框之间移动焦点、设置默认焦点等
class TextFocusRoutePage extends SimplePageRoute {
  TextFocusRoutePage() : super('输入框移动焦点');

  @override
  Widget pageBody() => _TextFocusWidget();
}

class _TextFocusWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TextFocusWidgetState();
}

class _TextFocusWidgetState extends State<_TextFocusWidget> {
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusScopeNode? focusScopeNode;

  _TextFocusWidgetState() {
    focusNode1.addListener(() {
      if (!focusNode1.hasFocus) {
        Fluttertoast.showToast(msg: "失去焦点");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          // 这里多了一个属性指定
          focusNode: focusNode1,
          autofocus: true,
          decoration: const InputDecoration(
              labelText: "input1",
              hintText: "请输入用户名",
              hintMaxLines: 1,
              hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
              prefixIcon: Icon(Icons.person)),
        ),
        TextField(
          focusNode: focusNode2,
          decoration: const InputDecoration(
              labelText: "密码",
              hintText: "请输入用密码",
              hintMaxLines: 1,
              hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
              prefixIcon: Icon(Icons.lock)),
        ),
        Builder(builder: (ctx) {
          return Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    //将焦点从第一个TextField移到第二个TextField
                    // 这是一种写法 FocusScope.of(context).requestFocus(focusNode2);
                    // 这是第二种写法
                    focusScopeNode ??= FocusScope.of(context);
                    focusScopeNode?.requestFocus(focusNode2);
                  },
                  child: const Text('移动焦点')),
              ElevatedButton(
                  onPressed: () {
                    focusNode1.unfocus();
                    focusNode2.unfocus();
                  },
                  child: const Text('隐藏键盘'))
            ],
          );
        }),
      ],
    );
  }
}
