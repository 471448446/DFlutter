import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:part_practise/utils/ui.dart';

class GestureDetectorClickRoutePage extends SimplePageRoute {
  GestureDetectorClickRoutePage({super.key}) : super('GestureDetector单击、双击、长按');

  @override
  Widget pageBody(BuildContext context) => _Page();
}

class _Page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageState();
}

class _PageState extends State<_Page> {
  String actionName = "尝试：单击、双击、长按";

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => setState(() => actionName = "单击"),
        onDoubleTap: () => setState(() => actionName = "双击"),
        onLongPress: () => setState(() => actionName = "长按"),
        onSecondaryTap: () {
          Fluttertoast.showToast(msg: '鼠标右键点击？？？？');
        },
        child: Center(
          child: Container(
            width: 200,
            height: 200,
            color: Colors.blue,
            child: Align(
              alignment: Alignment.center,
              child: Text(actionName),
            ),
          ),
        ),
      );
}
