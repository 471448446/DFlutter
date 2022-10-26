import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:part_practise/utils/ui.dart';

class AnimationSwitcherRoutePages extends SimplePageRoute {
  AnimationSwitcherRoutePages({super.key}) : super('AnimationSwitcher使用');

  @override
  Widget pageBody(BuildContext context) => _Pages();
}

class _Pages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PagesState();
}

class _PagesState extends State<_Pages> {
  int _counter = 0;
  var duration = const Duration(milliseconds: 1000);

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('默认是透明度动画'),
            AnimatedSwitcher(
              duration: duration,
              child: Text(
                "$_counter",

                /// 就指定了key，就有动画了
                //显示指定key，不同的key会被认为是不同的Text，这样才能执行动画
                key: ValueKey<int>(_counter),
                style: Theme.of(context).textTheme.headline4,
              ),
              transitionBuilder: (widget, animation) {
                // 默认是透明度变化。
                return FadeTransition(opacity: animation, child: widget);
              },
            ),
            const Text('组合多个动画'),
            AnimatedSwitcher(
              duration: duration,
              child: Text(
                "$_counter",
                key: ValueKey<int>(_counter),
                style: Theme.of(context).textTheme.headline4,
              ),
              transitionBuilder: (widget, animation) {
                //执行缩放+透明度动画
                // 这里组合了多组动画
                var animateOpacity =
                    Tween(begin: .0, end: 1.0).animate(animation);
                var animateScale =
                    Tween(begin: 0.4, end: 1.2).animate(animation);
                return AnimatedBuilder(
                    animation: animation,
                    builder: (BuildContext context, Widget? child) {
                      return Transform.scale(
                          scale: animateScale.value,
                          child: Opacity(
                              opacity: animateOpacity.value, child: widget));
                    });
              },
            ),
            const Text('同一个动画的正向和逆向正好是相反（对称）的'),
            // 新child是执行的正向动画，这里是从右往左
            // 老的child执行的方向动画，所以这里就是从左往右
            // 这个动画有问题，同时从右边进入，并且同时从右边退出
            AnimatedSwitcher(
              duration: duration,
              child: Text(
                "$_counter",
                key: ValueKey<int>(_counter),
                style: Theme.of(context).textTheme.headline4,
              ),
              transitionBuilder: (widget, animation) {
                var slideAnimation =
                    Tween(begin: const Offset(1, 0), end: const Offset(0, 0))
                        .animate(animation);
                return SlideTransition(
                  position: slideAnimation,
                  child: widget,
                );
              },
            ),
            const Text('修改'),
            // 修复上面的bug
            AnimatedSwitcher(
              duration: duration,
              child: Text(
                "$_counter",
                key: ValueKey<int>(_counter),
                style: Theme.of(context).textTheme.headline4,
              ),
              transitionBuilder: (widget, animation) {
                var slideAnimation =
                    Tween(begin: const Offset(1, 0), end: const Offset(0, 0))
                        .animate(animation);
                return MySlideTransition(
                  position: slideAnimation,
                  child: widget,
                );
              },
            ),
            const Text('通用的滑动'),
            AnimatedSwitcher(
              duration: duration,
              child: Text(
                "$_counter",
                key: ValueKey<int>(_counter),
                style: Theme.of(context).textTheme.headline4,
              ),
              transitionBuilder: (widget, animation) {
                return SlideTransitionX(
                  position: animation,
                  direction: AxisDirection.down,
                  child: widget,
                );
              },
            ),
            const Text('优化'),
            Padding(
              padding: const EdgeInsets.all(20),
              child: AnimatedSwitcher(
                duration: duration,
                child: Text(
                  "$_counter",
                  key: ValueKey<int>(_counter),
                  style: Theme.of(context).textTheme.headline4,
                ),
                transitionBuilder: (widget, animation) {
                  // 这里有点反常，因为SlideTransitionX将新旧替换了
                  var optAnimation =
                      Tween(begin: 1.0, end: 0.5).animate(animation);
                  return Opacity(
                    opacity: optAnimation.value,
                    child: SlideTransitionX(
                      position: animation,
                      direction: AxisDirection.left,
                      child: widget,
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    _counter++;
                  });
                },
                child: const Text(
                  "+1",
                  style: TextStyle(fontSize: 20),
                ))
          ],
        ),
      );
}

class MySlideTransition extends AnimatedWidget {
  const MySlideTransition({
    Key? key,
    required Animation<Offset> position,
    this.transformHitTests = true,
    required this.child,
  }) : super(key: key, listenable: position);

  final bool transformHitTests;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final position = listenable as Animation<Offset>;
    Offset offset = position.value;
    if (position.status == AnimationStatus.reverse) {
      offset = Offset(-offset.dx, offset.dy);
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}

class SlideTransitionX extends AnimatedWidget {
  SlideTransitionX({
    Key? key,
    required Animation<double> position,
    this.transformHitTests = true,
    this.direction = AxisDirection.down,
    required this.child,
  }) : super(key: key, listenable: position) {
    switch (direction) {
      case AxisDirection.up:
        _tween = Tween(begin: const Offset(0, 1), end: const Offset(0, 0));
        break;
      case AxisDirection.right:
        _tween = Tween(begin: const Offset(-1, 0), end: const Offset(0, 0));
        break;
      case AxisDirection.down:
        _tween = Tween(begin: const Offset(0, -1), end: const Offset(0, 0));
        break;
      case AxisDirection.left:
        _tween = Tween(begin: const Offset(1, 0), end: const Offset(0, 0));
        break;
    }
  }

  final bool transformHitTests;

  final Widget child;

  final AxisDirection direction;

  late final Tween<Offset> _tween;

  @override
  Widget build(BuildContext context) {
    final position = listenable as Animation<double>;
    Offset offset = _tween.evaluate(position);
    if (position.status == AnimationStatus.reverse) {
      switch (direction) {
        case AxisDirection.up:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.right:
          offset = Offset(-offset.dx, offset.dy);
          break;
        case AxisDirection.down:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.left:
          offset = Offset(-offset.dx, offset.dy);
          break;
      }
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}
