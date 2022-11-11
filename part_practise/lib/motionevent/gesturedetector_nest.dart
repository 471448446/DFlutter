import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:part_practise/utils/ui.dart';

/// 父子widget都设置了GestureDetector，以监听事件，当区域重叠时，会优先处理子类的
class GestureDetectorNestRoutePage extends SimplePageRoute {
  GestureDetectorNestRoutePage({super.key}) : super('GestureDetector嵌套');

  @override
  Widget pageBody(BuildContext context) => _Page();
}

class _Page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageState();
}

class _PageState extends State<_Page> {
  String actionName = "";

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => setState(() => actionName = "单击了父类"),
        child: Center(
          child: Container(
            width: 300,
            height: 300,
            color: Colors.blue,
            child: GestureDetector(
              onTap: () => setState(() => actionName = "单击了子类！！"),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: 150,
                  height: 150,
                  color: Colors.grey,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      actionName,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
