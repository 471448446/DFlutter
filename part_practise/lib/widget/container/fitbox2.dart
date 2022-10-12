import 'package:flutter/material.dart';
import 'package:part_practise/utils/ui.dart';

///https://book.flutterchina.club/chapter5/fittedbox.html
/// 加了FitBox就避免溢出父布局大小
class FitBox2RoutePage extends SimplePageRoute {
  FitBox2RoutePage({super.key}) : super('单行缩放布局');

  @override
  Widget pageBody() {
    return Center(
      child: Column(
        children: [
          const Text('下面这行是超出屏幕了'),
          wRow(' 90000000000000000 '),
          FittedBox(child: wRow(' 90000000000000000 ')),
          wRow(' 800 '),
          FittedBox(child: wRow(' 800 ')),
          const Text('----------------修改'),
          wRow(' 90000000000000000 '),
          SingleLineFittedBox(child: wRow(' 90000000000000000 ')),
          wRow(' 800 '),
          SingleLineFittedBox(child: wRow(' 800 ')),
        ]
            .map((e) => Padding(
                  // 统一为每个widget添加间距，这个思路不错
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: e,
                ))
            .toList(),
      ),
    );
  }

// 直接使用Row
  Widget wRow(String text) {
    Widget child = Text(text);
    child = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [child, child, child],
    );
    return child;
  }
}

class SingleLineFittedBox extends StatelessWidget {
  const SingleLineFittedBox({Key? key, this.child}) : super(key: key);
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    //LayoutBuilder 的使用，
    return LayoutBuilder(
      builder: (_, constraints) {
        return FittedBox(
          child: ConstrainedBox(
            constraints: constraints.copyWith(
              // constraints.maxWidth 当前环境是最大的宽，就是屏幕宽
              minWidth: constraints.maxWidth,
              maxWidth: double.infinity,
              //maxWidth: constraints.maxWidth
            ),
            child: child,
          ),
        );
      },
    );
  }
}
