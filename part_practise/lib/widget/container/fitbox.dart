import 'package:flutter/material.dart';
import 'package:part_practise/utils/ui.dart';

///https://book.flutterchina.club/chapter5/fittedbox.html
class FitBoxRoutePage extends SimplePageRoute {
  FitBoxRoutePage({super.key}) : super('FitBox');

  @override
  Widget pageBody() => Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Row(children: [Text('xx' * 30)]), //文本长度超出 Row 的最大宽度会溢出
          ),
          const Padding(
            padding: EdgeInsets.all(10),
            child: Text('下面显示了，子widget比父widget大时，怎样适配'),
          ),
          wContainer(BoxFit.none), // 第一个没有指定，展示的子widget的真实大小
          const Text('Flutter中国'),
          wContainer(BoxFit.contain), // 第二个指定了按比例缩放
          const Text('Flutter中国'),
          const Text('---------裁剪---------'),
          //要注意一点，在未指定适配方式时，虽然 FittedBox 子组件的大小超过了 FittedBox 父 Container 的空间，
          // 但FittedBox 自身还是要遵守其父组件传递的约束，所以最终 FittedBox 的本身的大小是 50×50，
          // 这也是为什么蓝色会和下面文本重叠的原因，因为在布局空间内，父Container只占50×50的大小，
          // 接下来文本会紧挨着Container进行布局，而此时Container 中有子组件的大小超过了自己，
          // 所以最终的效果就是绘制范围超出了Container，但布局位置是正常的，所以就重叠了。
          // 如果我们不想让蓝色超出父组件布局范围，那么可以可以使用 ClipRect 对超出的部分剪裁掉即可
          wContainerClip(BoxFit.none), // 第一个没有指定，展示的子widget的真实大小
          const Text('Flutter中国'),
        ],
      );

  Widget wContainer(BoxFit boxFit) {
    return Container(
      width: 50,
      height: 50,
      color: Colors.red,
      child: FittedBox(
        fit: boxFit,
        // 子容器超过父容器大小
        child: Container(width: 60, height: 70, color: Colors.blue),
      ),
    );
  }

  Widget wContainerClip(BoxFit boxFit) {
    return ClipRect(
      child: Container(
        width: 50,
        height: 50,
        color: Colors.red,
        child: FittedBox(
          fit: boxFit,
          // 子容器超过父容器大小
          child: Container(width: 60, height: 70, color: Colors.blue),
        ),
      ),
    );
  }
}
