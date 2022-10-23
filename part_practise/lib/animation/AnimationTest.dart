import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:part_practise/utils/ui.dart';

class AnimationRoutePage extends SimplePageRoute {
  AnimationRoutePage({super.key}) : super('动画演示');

  @override
  Widget pageBody(BuildContext context) => Stack(
        children: [
          Positioned(
            top: 0,
            child: _Pages(),
          ),
          Positioned(
            top: 220,
            child: _Pages2(),
          ),
          Positioned(
            top: 440,
            child: _Pages3(),
          )
        ],
      );
}
// class _PagesTest extends StatefulWidget{
//
// }
// class _PagesTestState extends State<>

/// 方式三
/// 缩小了刷新范围，只刷新AnimationBuilder里面的一部分
class _Pages3 extends StatefulWidget {
  @override
  State createState() => _Pages3State();
}

class _Pages3State extends State<_Pages3> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    //图片宽高从0变到200
    animation = Tween(begin: 0.0, end: 200.0).animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          //动画执行结束时反向执行动画
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          //动画恢复到初始状态时执行动画（正向）
          controller.forward();
        }
      });
    //启动动画
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    // return AnimatedImage(
    //   animation: animation,
    // );
    return AnimatedBuilder(
      animation: animation,
      child: Image.asset(
        "assets/images/icon.png",
        fit: BoxFit.fill,
      ),
      builder: (BuildContext ctx, child) {
        return SizedBox(
          height: animation.value,
          width: animation.value,
          child: child,
        );
      },
    );
  }

  @override
  dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}

/// 方式二
/// 用AnimatedWidget 可以从动画中分离出 widget
/// 还是通过setState来刷新UI
class AnimatedImage extends AnimatedWidget {
  const AnimatedImage({
    Key? key,
    required Animation<double> animation,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Image.asset(
        "assets/images/icon.png",
        width: animation.value,
        height: animation.value,
        fit: BoxFit.fill,
      ),
    );
  }
}

class _Pages2 extends StatefulWidget {
  @override
  _Pages2State createState() => _Pages2State();
}

class _Pages2State extends State<_Pages2> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    //图片宽高从0变到200
    animation = Tween(begin: 0.0, end: 200.0).animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          //动画执行结束时反向执行动画
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          //动画恢复到初始状态时执行动画（正向）
          controller.forward();
        }
      });
    //启动动画
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedImage(
      animation: animation,
    );
  }

  @override
  dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}

/// 方式一
class _Pages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PagesState();
}

//需要继承TickerProvider，如果有多个AnimationController，则应该使用TickerProviderStateMixin。
class _PagesState extends State<_Pages> with SingleTickerProviderStateMixin {
  // 不需要
  double _width = 100;

  late Animation<double> animation;
  late AnimationController controller;

  @override
  initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // 添加加速器
    CurvedAnimation curve =
        CurvedAnimation(parent: controller, curve: Curves.bounceIn);
    //匀速
    //图片宽高从0变到200
    animation = Tween(begin: 0.0, end: 200.0).animate(curve)
      ..addListener(() {
        // 这里并不需要获取值，并保存后刷新，直接用animation.value
        setState(() => {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          //动画执行结束时反向执行动画
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          //动画恢复到初始状态时执行动画（正向）
          controller.forward();
        }
      });

    //启动动画(正向执行)
    controller.forward();
  }

  @override
  Widget build(BuildContext context) => Center(
        child: Image.asset(
          'assets/images/icon.png',
          width: animation.value,
          height: animation.value,
          fit: BoxFit.fill,
        ),
      );

  @override
  dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}
