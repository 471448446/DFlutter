import 'package:flutter/material.dart';
import 'package:part_practise/utils/ui.dart';
import 'dart:math' as math;

class TransformRoutePage extends SimplePageRoute {
  TransformRoutePage({super.key}) : super('Transform');

  @override
  Widget pageBody() => SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(50),
              // 下面才是例子，这里加padding，是因为skew后，被遮盖了
              child: Container(
                color: Colors.black,
                child: Transform(
                  alignment: Alignment.topRight, //相对于坐标系原点的对齐方式
                  transform: Matrix4.skewY(0.3), //沿Y轴倾斜0.3弧度
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    color: Colors.deepOrange,
                    child: const Text('Apartment for rent!'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50),
              child: DecoratedBox(
                decoration: const BoxDecoration(color: Colors.red),
                //默认原点为左上角，左移20像素，向上平移5像素
                child: Transform.translate(
                  offset: const Offset(-20.0, -5.0),
                  child: const Text("Hello world"),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(50),
              child: DecoratedBox(
                decoration: const BoxDecoration(color: Colors.red),
                child: Transform.rotate(
                  //旋转90度
                  angle: math.pi / 2,
                  child: Text("Hello world"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50),
              child: DecoratedBox(
                  decoration: const BoxDecoration(color: Colors.red),
                  child: Transform.scale(
                      scale: 1.5, //放大到1.5倍
                      child: const Text("Hello world"))),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 50),
              child: Text(
                  'Transform是应用在绘制阶段，控件的大小是不会变化的，而RotatedBox是应用在布局layout阶段，会影响位置和大小'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DecoratedBox(
                  decoration: const BoxDecoration(color: Colors.red),
                  //将Transform.rotate换成RotatedBox
                  child: Transform.rotate(
                    angle: math.pi / 2, //旋转90度(1/4圈)
                    child: const Text("Hello world"),
                  ),
                ),
                const Text(
                  "你好",
                  style: TextStyle(color: Colors.green, fontSize: 18.0),
                )
              ],
            ),

            ///由于RotatedBox是作用于layout阶段，所以子组件会旋转90度（而不只是绘制的内容），decoration会作用到子组件所占用的实际空间上
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                DecoratedBox(
                  decoration: BoxDecoration(color: Colors.red),
                  //将Transform.rotate换成RotatedBox
                  child: RotatedBox(
                    quarterTurns: 1, //旋转90度(1/4圈)
                    child: Text("Hello world"),
                  ),
                ),
                Text(
                  "你好",
                  style: TextStyle(color: Colors.green, fontSize: 18.0),
                )
              ],
            )
          ],
        ),
      );
}
