import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:part_practise/utils/ui.dart';

/// UnconstrainedBox 可以不授父组件的限制，但是无法修改父组件的大小
/// 但是，读者请注意，UnconstrainedBox对父组件限制的“去除”并非是真正的去除：
/// 上面例子中虽然红色区域大小是90×20，但上方仍然有80的空白空间。也就是说父限制的minHeight(100.0)仍然是生效的，
/// 只不过它不影响最终子元素redBox的大小，但仍然还是占有相应的空间，
/// 可以认为此时的父ConstrainedBox是作用于子UnconstrainedBox上，而redBox只受子ConstrainedBox限制，这一点请读者务必注意。
///
/// Column是水平剧中显示的，所以看到的效果数无法做对齐，先忽略。？？这个其实是有个对其方式，可以通过纵轴crossAxisAlignment来修改
/// 另外，第二个红色框框距离文字有一段距离是因为上面的（但是）的原因
class UnconstrainedBoxRoutePage extends SimplePageRoute {
  UnconstrainedBoxRoutePage({super.key}) : super("UnconstrainedBoxRoutePage");

  @override
  Widget pageBody(BuildContext context) {
    const redBox = DecoratedBox(
      decoration: BoxDecoration(color: Colors.red),
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // 最为对比
        const Text('60*100大小如下'),
        ConstrainedBox(
          // 约束布局，这里限制了最小宽60，高最小是100
          constraints: const BoxConstraints(minWidth: 60, minHeight: 100),
          child: const SizedBox(child: redBox),
        ),
        const Text('不受父组件约束'),
        ConstrainedBox(
          // 约束布局，这里限制了最小宽60，高最小是100
          constraints: const BoxConstraints(minWidth: 60, minHeight: 100),
          child: UnconstrainedBox(
            // 取消限制
            child: ConstrainedBox(
              // 约束布局，这里限制了宽190，高最小是20
              constraints: const BoxConstraints(minWidth: 90, minHeight: 20),
              child: const SizedBox(
                // 由于受到了父布局的限制，这里大小被修改了，虽然指定了5，但是最终是20
                height: 5,
                child: redBox,
              ),
            ),
          ),
        ),
        const Text('下面是一个实例，当使用SizeBox指定大小时，无效！！！因为父组件已经用约束布局限制的子组件的大小'),
        AppBar(
          title: const Text('右边的进度条大小有问题'),
          actions: const <Widget>[
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation(Colors.white70),
              ),
            )
          ],
        ),
        const Text('因为AppBar已经指定了大小，修改方案：使用UnconstrainedBox,移除父组件的限制'),
        AppBar(
          title: const Text('修改后'),
          actions: const <Widget>[
            UnconstrainedBox(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation(Colors.white70),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
