import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:part_practise/utils/ui.dart';

class CustomWidgetFromCombineRoutePage extends SimplePageRoute {
  CustomWidgetFromCombineRoutePage({super.key}) : super('组合现有的widget');

  @override
  Widget pageBody(BuildContext context) => TurnBoxRoute();
}

class TurnBoxRoute extends StatefulWidget {
  const TurnBoxRoute({Key? key}) : super(key: key);

  @override
  _TurnBoxRouteState createState() => _TurnBoxRouteState();
}

class _TurnBoxRouteState extends State<TurnBoxRoute> {
  double _turns = .0;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          TurnBox(turns: _turns, child: Image.asset('assets/images/icon.png')),
          TurnBox(turns: _turns, child: const Text('XXX')),
          TurnBox(
              turns: _turns,
              duration: 1000,
              child: Image.asset('assets/images/icon.png')),
          ElevatedButton(
            child: const Text("顺时针旋转1/5圈"),
            onPressed: () {
              setState(() {
                _turns += .2;
              });
            },
          ),
          ElevatedButton(
            child: const Text("逆时针旋转1/5圈"),
            onPressed: () {
              setState(() {
                _turns -= .2;
              });
            },
          )
        ]
            .map((e) => Padding(
                  padding: const EdgeInsets.all(30),
                  child: e,
                ))
            .toList(),
      );
}

class TurnBox extends StatefulWidget {
  final int duration;
  final double turns;
  final Widget child;

  TurnBox({this.duration = 400, this.turns = 0.2, required this.child});

  @override
  State<StatefulWidget> createState() => _TurnBoxState();
}

class _TurnBoxState extends State<TurnBox> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, lowerBound: -double.infinity, upperBound: double.infinity);
    _animationController.value = widget.turns;
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _animationController,
      child: widget.child,
    );
  }

  @override
  void didUpdateWidget(TurnBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    //旋转角度发生变化时执行过渡动画
    if (oldWidget.turns != widget.turns) {
      // 绑定动画，之前是Tween.animation
      _animationController.animateTo(
        widget.turns,
        duration: Duration(milliseconds: widget.duration),
        curve: Curves.easeOut,
      );
    }
  }
}
