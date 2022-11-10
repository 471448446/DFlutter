import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:part_practise/utils/ui.dart';

/// 强制切换页面
/// todo: https://blog.csdn.net/weixin_34194317/article/details/88060046
/// 说是IOS上不行，待验证，issue已经杯关闭了
class OrientationSetRoutePage extends SimplePageRoute {
  OrientationSetRoutePage({super.key}) : super('强制横屏，退出页面后会恢复');

  @override
  Widget pageBody(BuildContext context) {
    // // 要在build()方法里面
    // SystemChrome.setPreferredOrientations(
    //     [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    return _Pages();
  }
}

class _Pages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PagesState();
}

class _PagesState extends State<_Pages> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  set() async {
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
  }

  restore() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
  }

  @override
  Widget build(BuildContext context) => const Center();
}
