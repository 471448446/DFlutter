import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:part_practise/utils/ui.dart';

/// 属性的过度动画，既设置某个属性时，从旧值渐变到新的属性值

class TransitTestRoutePage extends SimplePageRoute {
  TransitTestRoutePage({super.key}) : super('属性过渡动画');

  @override
  Widget pageBody(BuildContext context) => _Pages();
}

class _Pages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PagesStat();
}

class _PagesStat extends State<_Pages> {
  TextStyle textStyle = const TextStyle(color: Colors.white, fontSize: 20);
  TextStyle textStyle2 = const TextStyle(
    color: Colors.red,
    fontSize: 25,
    decorationStyle: TextDecorationStyle.solid,
  );

  MaterialColor _colorChange = Colors.yellow;
  MaterialColor _colorChange2 = Colors.red;
  double _padding = 10;
  double _opacity = 1.0;
  var _alignmentDirectional = Alignment.topLeft;
  var _left = 0.0;
  late TextStyle _textStyle;

  @override
  void initState() {
    super.initState();
    _textStyle = textStyle;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text('过渡组件'),
          TransitDecorationWidget(
            boxDecoration: BoxDecoration(color: _colorChange),
            curve: Curves.linear,
            duration: const Duration(seconds: 2),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: double.infinity),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    if (_colorChange == Colors.yellow) {
                      _colorChange = Colors.red;
                    } else {
                      _colorChange = Colors.yellow;
                    }
                  });
                },
                child: Text(
                  '过渡动画',
                  style: textStyle,
                ),
              ),
            ),
          ),
          TransDecorationWidget2(
            decoration: BoxDecoration(color: _colorChange2),
            curve: Curves.linear,
            duration: const Duration(seconds: 2),
            child: TextButton(
              onPressed: () {
                setState(() {
                  if (_colorChange2 == Colors.yellow) {
                    _colorChange2 = Colors.red;
                  } else {
                    _colorChange2 = Colors.yellow;
                  }
                });
              },
              child: Text(
                '过渡动画2',
                style: textStyle,
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  if (_padding == 10) {
                    _padding = 20;
                  } else {
                    _padding = 10;
                  }
                });
              },
              child: AnimatedPadding(
                padding: EdgeInsets.all(_padding),
                duration: const Duration(seconds: 2),
                child: Text(
                  'AnimatedPadding',
                  style: textStyle,
                ),
              )),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  if (_opacity == 1) {
                    _opacity = 0.2;
                  } else {
                    _opacity = 1;
                  }
                });
              },
              child: AnimatedOpacity(
                opacity: _opacity,
                duration: const Duration(seconds: 2),
                child: Text(
                  'AnimatedOpacity',
                  style: textStyle,
                ),
              )),
          Container(
            height: 200,
            color: Colors.grey,
            child: AnimatedAlign(
              alignment: _alignmentDirectional,
              duration: const Duration(seconds: 2),
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      final old = _alignmentDirectional;
                      if (_alignmentDirectional == Alignment.topLeft) {
                        _alignmentDirectional = Alignment.bottomRight;
                      } else {
                        _alignmentDirectional = Alignment.topLeft;
                      }
                      print(
                          "============> align $old to $_alignmentDirectional");
                    });
                  },
                  child: Text(
                    'AnimatedAlign',
                    style: textStyle,
                  )),
            ),
          ),
          Container(
            height: 100,
            color: Colors.grey,
            child: Stack(
              children: [
                AnimatedPositioned(
                  left: _left,
                  duration: const Duration(seconds: 2),
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (_left == 50) {
                            _left = 0;
                          } else {
                            _left = 50;
                          }
                        });
                      },
                      child: Text(
                        'AnimatedPositioned',
                        style: textStyle,
                      )),
                )
              ],
            ),
          ),
          AnimatedContainer(
            padding: EdgeInsets.all(_padding),
            color: Colors.grey,
            duration: const Duration(seconds: 2),
            child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_padding == 10) {
                      _padding = 20;
                    } else {
                      _padding = 10;
                    }
                  });
                },
                child: Text(
                  'AnimatedContainer',
                  style: textStyle,
                )),
          ),
          AnimatedDefaultTextStyle(
            style: _textStyle,
            duration: const Duration(seconds: 2),
            // 这里没有使用button，因为button的属性改变有点问题
            child: GestureDetector(
              child: Container(
                color: Colors.grey,
                child: const Text(
                  'AnimatedDefaultTextStyle',
                ),
              ),
              onTap: () {
                setState(() {
                  final old = _textStyle;
                  if (_textStyle == textStyle) {
                    _textStyle = textStyle2;
                  } else {
                    _textStyle = textStyle;
                  }
                  print("==========text change : $old to $_textStyle");
                });
              },
            ),
          ),
        ]
            .map((e) => Padding(
                  padding: const EdgeInsets.all(8),
                  child: e,
                ))
            .toList(),
      ),
    );
  }
}

class TransitDecorationWidget extends StatefulWidget {
  // 子元素
  Widget child;

  // 这里时对Decoration做动画，所以需要提供装饰者
  BoxDecoration boxDecoration;

  /// ---动画部分
  // 动画的样式
  Curve curve;

  // 动画时间
  Duration duration;

  // 动画时间（反向）
  Duration? reverseDuration;

  TransitDecorationWidget(
      {super.key,
      required this.child,
      required this.boxDecoration,
      required this.curve,
      required this.duration,
      this.reverseDuration});

  @override
  State<StatefulWidget> createState() => _TransitFiledState();
}

class _TransitFiledState extends State<TransitDecorationWidget>
    with SingleTickerProviderStateMixin {
  // 动画基础功能，controller
  late AnimationController _controller;
  late CurvedAnimation _animation;
  late DecorationTween _tween;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: widget.duration,
        reverseDuration: widget.reverseDuration,
        vsync: this);
    _tween = DecorationTween(begin: widget.boxDecoration);
    _updateCurve();
  }

  void _updateCurve() {
    _animation = CurvedAnimation(parent: _controller, curve: widget.curve);
  }

  @override
  void didUpdateWidget(TransitDecorationWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("-----widget 发送变化");
    if (widget.curve != oldWidget.curve) _updateCurve();
    _controller.duration = widget.duration;
    _controller.reverseDuration = widget.reverseDuration;
    //正在执行过渡动画
    if (widget.boxDecoration != (_tween.end ?? _tween.begin)) {
      _tween
        ..begin = _tween.evaluate(_animation) // 注意这不是animation()
        ..end = widget.boxDecoration;

      _controller
        ..value = 0.0
        ..forward();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _animation.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        return DecoratedBox(
          decoration: _tween.animate(_animation).value,
          child: widget.child,
        );
      });
}

///-----改进方式
class TransDecorationWidget2 extends ImplicitlyAnimatedWidget {
  const TransDecorationWidget2({
    Key? key,
    required this.decoration,
    Curve curve = Curves.linear,
    required Duration duration,
    required this.child,
  }) : super(
          key: key,
          curve: curve,
          duration: duration,
        );
  final BoxDecoration decoration;
  final Widget child;

  @override
  ImplicitlyAnimatedWidgetState<TransDecorationWidget2> createState() {
    return _AnimatedDecoratedBoxState();
  }
}

class _AnimatedDecoratedBoxState
    extends ImplicitlyAnimatedWidgetState<TransDecorationWidget2> {
  DecorationTween? _decoration;

  ///在动画执行过程中，每一帧都会调用build方法（调用逻辑在ImplicitlyAnimatedWidgetState中），
  ///所以在build方法中我们需要构建每一帧的DecoratedBox状态，因此得算出每一帧的decoration 状态，
  ///这个我们可以通过_decoration.evaluate(animation) 来算出，其中animation是
  ///ImplicitlyAnimatedWidgetState基类中定义的对象，_decoration是我们自定义的一个DecorationTween类型的对象，
  ///那么现在的问题就是它是在什么时候被赋值的呢？要回答这个问题，我们就得搞清楚什么时候需要对_decoration赋值。
  ///我们知道_decoration是一个Tween，而Tween的主要职责就是定义动画的起始状态（begin）和终止状态(end)。
  ///对于AnimatedDecoratedBox来说，decoration的终止状态就是用户传给它的值，而起始状态是不确定的，有以下两种情况
  @override
  Widget build(BuildContext context) {
    print("-------DecorationTween---build $_decoration");
    return DecoratedBox(
      decoration: _decoration!.evaluate(animation),
      child: widget.child,
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    print("-------DecorationTween---forEachTween $_decoration");
    _decoration = visitor(
      _decoration, //当前的tween，第一次调用为null
      widget.decoration, // 终止状态
      (value) => DecorationTween(begin: value), //Tween构造器，在上述三种情况下会被调用以更新tween
    ) as DecorationTween;
  }
}
