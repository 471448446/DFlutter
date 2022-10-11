import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:part_practise/utils/ui.dart';

/// 弹性布局
class FlexLayoutRoutePage extends SimplePageRoute {
  FlexLayoutRoutePage({super.key}) : super('FlexLayout');

  @override
  Widget pageBody() => Flex(
        direction: Axis.vertical,
        children: [
          const Text('使用flex属性实现weight'),
          Flex(
            direction: Axis.horizontal,
            children: [
              // 类似weight
              Expanded(
                  flex: 1,
                  child: Container(
                    height: 30,
                    color: Colors.teal,
                  )),
              const Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 30,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.blue),
                    ),
                  )),
            ],
          ),
          const Text('下面是：Flex的三个子widget，在垂直方向按2：1：1来占用100像素的空间'),
          Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                height: 100,
                child: Flex(
                  direction: Axis.vertical,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        // 这个height没有用，因为父类限制的大小
                        height: 30.0,
                        color: Colors.red,
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 30.0,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ))
        ],
      );
}
