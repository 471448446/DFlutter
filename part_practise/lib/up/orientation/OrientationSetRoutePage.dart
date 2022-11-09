import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:part_practise/utils/ui.dart';

class OrientationSetRoutePage extends SimplePageRoute {
  OrientationSetRoutePage({super.key}) : super('强制横屏');

  @override
  Widget pageBody(BuildContext context) => const Center();
}

class _Pages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PagesState();
}

class _PagesState extends State<_Pages> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown]);
  }

  @override
  Widget build(BuildContext context) => const Center();
}
