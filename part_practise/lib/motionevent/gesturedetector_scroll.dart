import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:part_practise/utils/ui.dart';

class GestureDetectorMoveRoutePage extends SimplePageRoute {
  GestureDetectorMoveRoutePage({super.key}) : super('GestureDetector识别滑动');

  @override
  Widget pageBody(BuildContext context) => _Page();
}

class _Page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageState();
}

class _PageState extends State<_Page> {
  double _top = 20.0; //距顶部的偏移
  double _left = 20.0; //距左边的偏移
  @override
  Widget build(BuildContext context) => Stack(
        children: <Widget>[
          Positioned(
            top: _top,
            left: _left,
            child: GestureDetector(
              child: const CircleAvatar(child: Text("A")),
              //手指按下时会触发此回调
              onPanDown: (DragDownDetails e) {
                //打印手指按下的位置(相对于屏幕)
                print("用户手指按下：${e.globalPosition}");
              },
              //手指滑动时会触发此回调
              onPanUpdate: (DragUpdateDetails e) {
                //用户手指滑动时，更新偏移，重新构建
                setState(() {
                  _left += e.delta.dx;
                  _top += e.delta.dy;
                });
              },
              onPanEnd: (DragEndDetails e) {
                //打印滑动结束时在x、y轴上的速度
                print("用户手指抬起：e.velocity");
              },
              // 设置了竖直滑动，会拦截onPanUpdate的竖直滑动
              // onVerticalDragUpdate: (DragUpdateDetails e){
              //
              // },
            ),
          )
        ],
      );
}
