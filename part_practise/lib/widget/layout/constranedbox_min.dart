import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:part_practise/utils/ui.dart';

/// ConstrainedBox、SizeBox都是可以限制大小的盒子
class ConstrainedBoxRoutePage extends SimplePageRoute {
  ConstrainedBoxRoutePage({super.key}) : super("ConstrainedBox & SizeBox");

  @override
  Widget pageBody(BuildContext context) {
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
        const Text('固定大小，和后面一个的效果一样'),
        const SizedBox(width: 50, height: 50, child: redBox),
        const Text('固定大小，跟上面一样效果'),
        ConstrainedBox(
          constraints: const BoxConstraints.tightFor(width: 50, height: 50),
          child: redBox,
        ),
        const Text('多重限制-最小1'),
        // 父子取最大的
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 60.0, minHeight: 60.0),
          // 父
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 90.0, minHeight: 20.0),
            // 子
            child: redBox,
          ),
        ),
        const Text('多重限制-最小2'),
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 90.0, minHeight: 20.0),
          // 父
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 60.0, minHeight: 60.0),
            // 子
            child: redBox,
          ),
        ),
        const Text('多重限制-最大1'),
        // 父子取最大的
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 60.0, maxHeight: 60.0),
          // 父
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 90.0, maxHeight: 20.0),
            // 子
            child: redBox,
          ),
        ),
        const Text('多重限制-最大2'),
        // max 直接没有了？
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 90.0, maxHeight: 20.0),
          // 父
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 60.0, maxHeight: 60.0),
            // 子
            child: redBox,
          ),
        ),
      ],
    );
  }
}
