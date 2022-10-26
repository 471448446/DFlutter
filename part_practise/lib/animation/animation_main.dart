import 'package:flutter/cupertino.dart';
import 'package:part_practise/animation/AnimationTest.dart';
import 'package:part_practise/animation/combine_animation.dart';
import 'package:part_practise/animation/hero.dart';
import 'package:part_practise/utils/ui.dart';

/// 动画
class AnimationDemoWidget extends StatelessWidget {
  const AnimationDemoWidget({super.key});

  @override
  Widget build(BuildContext context) => Column(children: [
        const TextTitleWidget("动画"),
        Wrap(
            spacing: 1.0, // 主轴(水平)方向间距
            runSpacing: 1.0, // 纵轴（垂直）方向间距
            alignment: WrapAlignment.start, //沿主轴方向居中
            children: [
              TextEntranceWidget.createEntranceAndWait(
                  context, "动画", AnimationRoutePage()),

              //https://book.flutterchina.club/chapter9/route_transition.html
              TextEntranceWidget.createEntrance(context, "页面切换动画", () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => AnimationRoutePage(),
                    ));
              }),
              TextEntranceWidget.createEntrance(context, "页面切换动画", () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 1000),
                        //动画时间为500毫秒,
                        pageBuilder: (BuildContext context,
                                Animation<double> animation,
                                Animation secondaryAnimation) =>
                            FadeTransition(
                              //使用渐隐渐入过渡,
                              opacity: animation,
                              child: AnimationRoutePage(), //路由B
                            )));
              }),
              TextEntranceWidget.createEntranceAndWait(
                  context, "Hero动画", HeroDemoRoutePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, "组合多个动画", CombineAnimationRoutePage()),

              ///todo 更多
            ])
      ]);
}
