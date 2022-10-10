import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:part_practise/utils/ui.dart';

/// ConstrainedBox、SizeBox都是可以限制大小的盒子
class ConstrainedBoxRoutePage extends SimplePageRoute {
  ConstrainedBoxRoutePage({super.key}) : super("ConstrainedBox & SizeBox");

  @override
  Widget pageBody() {
    const redBox = DecoratedBox(
      decoration: BoxDecoration(color: Colors.red),
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text('限制子widget大小'),
        ConstrainedBox(
          // 约束布局，这里限制了宽无限大，高最小是50
          constraints:
              const BoxConstraints(minWidth: double.infinity, minHeight: 50),
          child: const SizedBox(
            // 由于受到了父布局的限制，这里大小被修改了，虽然指定了5，但是最终是50
            height: 5,
            child: redBox,
          ),
        ),
      ],
    );
  }
}
