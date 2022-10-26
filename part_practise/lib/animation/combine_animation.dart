import 'package:flutter/material.dart';
import 'package:part_practise/utils/ui.dart';

/// 组合多个动画执行，类似于Android中的AnimatorSet
/// 需要借助Interval来控制进度，就是哪个先执行，哪个后执行
/// 然后共用同一个Controller和TickerProvider
class CombineAnimationRoutePage extends SimplePageRoute {
  CombineAnimationRoutePage({super.key}) : super('组合多个动画');

  @override
  Widget pageBody(BuildContext context) => _Pages();
}

class _Pages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PagesState();
}

class _PagesState extends State<_Pages> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
  }

  @override
  void deactivate() {
    super.deactivate();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          FloatingActionButton(
              onPressed: () {
                _playAnimation();
              },
              child: const Text("start")),
          Container(
            width: 300.0,
            height: 300.0,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              border: Border.all(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            //调用我们定义的交错动画Widget
            child: _AnimationWidget(controller: _controller),
          )
        ],
      );

  void _playAnimation() async {
    try {
      await _controller.forward().orCancel;
      await _controller.reverse().orCancel;
    } on TickerCanceled {}
  }
}

class _AnimationWidget extends StatelessWidget {
  AnimationController controller;
  late Animation<double> grow;
  late Animation<Color?> color;
  late Animation<EdgeInsets> padding;

  _AnimationWidget({required this.controller}) {
    grow = Tween(begin: .0, end: 300.0).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.6, curve: Curves.ease)));
    color = ColorTween(begin: Colors.yellow, end: Colors.blue).animate(
        CurvedAnimation(parent: controller, curve: const Interval(.0, 0.6)));
    padding = Tween<EdgeInsets>(
            begin: const EdgeInsets.only(left: 0.0),
            end: const EdgeInsets.only(left: 100.0))
        .animate(CurvedAnimation(
            parent: controller, curve: const Interval(0.6, 1.0)));
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        return Container(
            alignment: Alignment.bottomCenter,
            padding: padding.value,
            child: Container(
              color: color.value,
              width: 50.0,
              height: grow.value,
            ));
      });
}
