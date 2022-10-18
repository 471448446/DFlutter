import 'package:flutter/material.dart';
import 'package:part_practise/utils/ui.dart';

class AlignLayoutRoutePage extends SimplePageRoute {
  AlignLayoutRoutePage({super.key}) : super('WrapLayout');

  @override
  Widget pageBody(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: [
            const Text('红色边框是父控件，中间的方块是对其Widget'),
            Container(
              height: 90,
              decoration: BoxDecoration(border: Border.all(color: Colors.red)),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: 30.0,
                  height: 30.0,
                  color: Colors.blue,
                ),
              ),
            ),
            const Text('不指定矩形的宽高，通过widthFactor来计算父组件的宽高'),
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.red)),
              child: Align(
                // 因为Align的子元素大小是固定的，这里是30*30，父组件的宽高 w= 30 *widthFactor h = 30*heightFactor 666!
                widthFactor: 3,
                heightFactor: 3,
                alignment: Alignment.center,
                child: Container(
                  width: 30.0,
                  height: 30.0,
                  color: Colors.blue,
                ),
              ),
            ),
            const Text('偏移！！！骚操作 Alignment'),
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.red)),
              child: Align(
                // 因为Align的子元素大小是固定的，这里是30*30，父组件的宽高 w= 30 *widthFactor h = 30*heightFactor 666!
                widthFactor: 2,
                heightFactor: 2,
                alignment: const Alignment(2, 0),
                child: Container(
                  width: 30.0,
                  height: 30.0,
                  color: Colors.blue,
                ),
              ),
            ),
            const Text('偏移！！！骚操作 FractionalOffset'),
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.red)),
              child: Align(
                // 因为Align的子元素大小是固定的，这里是30*30，父组件的宽高 w= 30 *widthFactor h = 30*heightFactor 666!
                widthFactor: 2,
                heightFactor: 2,
                alignment: const FractionalOffset(0.2, 0.6),
                child: Container(
                  width: 30.0,
                  height: 30.0,
                  color: Colors.blue,
                ),
              ),
            ),
            const Text('下面这个是Center，Center就是对其方式为center的Alignment'),
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.red)),
              child: Center(
                child: Container(
                  width: 30.0,
                  height: 30.0,
                  color: Colors.blue,
                ),
              ),
            ),
            const Text('需要注意widthFactor为null就是希望最大'),
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.red)),
              child: Center(
                widthFactor: 2,
                heightFactor: 2,
                child: Container(
                  width: 30.0,
                  height: 30.0,
                  color: Colors.blue,
                ),
              ),
            ),
            const Text('下面是一个距离X轴30的对其例子'),
            // 先把30有多元提现出来
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 30,
                height: 30,
                color: Colors.red,
              ),
            ),
            Container(
              height: 100,
              decoration: BoxDecoration(border: Border.all(color: Colors.red)),
              child: Align(
                alignment: const FractionalOffset(0.1, 0),// 这里指定了0.1，那么实际篇一应该是 0.1*30=3 从运行效果来看，很明显不是这样，
                // 看起来，不是这么回事，这个0.1应该是父组件宽的0.1，这里父组件宽是屏幕宽，所以不一定对得起
                child: Container(
                  width: 30.0,
                  height: 30.0,
                  color: Colors.blue,
                ),
              ),
            ),
            //如果用Stack来，好像更方便指定距离呢
            Container(
              height: 100,
              decoration: BoxDecoration(border: Border.all(color: Colors.red)),
              child: Stack(
                alignment: AlignmentDirectional.topStart,//规定没有使用Positioned的组件对其方式，这里以左上角对其
                children: [
                  Positioned(
                      left: 30,
                      child: Container(
                        width: 30.0,
                        height: 30.0,
                        color: Colors.blue,
                      )),
                  // 这里可以看出，这个0.1是y轴的0.1
                  Align(
                      alignment: const FractionalOffset(0, 0.1),
                      child: Container(
                        width: 30.0,
                        height: 30.0,
                        color: Colors.red,
                      ))
                ],
              ),
            ),
          ],
        ),
      );
}
