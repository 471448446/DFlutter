import 'package:flutter/material.dart';
import 'package:part_practise/utils/ui.dart';

class HeroDemoRoutePage extends SimplePageRoute {
  HeroDemoRoutePage({super.key}) : super('Hero');

  @override
  Widget pageBody(BuildContext context) => const HeroAnimationRouteA();
}

/// 作者实现的hero例子
class HeroAnimationRouteA extends StatelessWidget {
  const HeroAnimationRouteA({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Column(
        children: <Widget>[
          InkWell(
            child: Hero(
              tag: "avatar", //唯一标记，前后两个路由页Hero的tag必须相同
              child: ClipOval(
                child: Image.asset(
                  "assets/images/icon.png",
                  width: 50.0,
                ),
              ),
            ),
            onTap: () {
              //打开B路由
              Navigator.push(
                  context,
                  PageRouteBuilder(
                    // transitionDuration: const Duration(microseconds: 4500),
                    pageBuilder: (
                      BuildContext context,
                      animation,
                      secondaryAnimation,
                    ) {
                      return FadeTransition(
                        opacity: animation,
                        child: Scaffold(
                          appBar: AppBar(
                            title: const Text("原图"),
                          ),
                          body: const HeroAnimationRouteB(),
                        ),
                      );
                    },
                  ));
            },
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text("点击头像"),
          )
        ],
      ),
    );
  }
}

class HeroAnimationRouteB extends StatelessWidget {
  const HeroAnimationRouteB({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
        tag: "avatar", //唯一标记，前后两个路由页Hero的tag必须相同
        child: Image.asset("assets/images/icon.png"),
      ),
    );
  }
}
