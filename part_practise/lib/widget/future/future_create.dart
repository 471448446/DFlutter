import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:part_practise/utils/ui.dart';

class FutureCreateRoutePage extends SimplePageRoute {
  FutureCreateRoutePage({super.key}) : super('FutureCreate');

  @override
  Widget pageBody(BuildContext context) => _Page();
}

class _Page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageState();
}

class PageState extends State<_Page> {
  @override
  void initState() {
    super.initState();
    var future = Future(() async {
      print("start");
      await Future.delayed(const Duration(seconds: 2));
      return "suc";
    }).then((value) => print(value));
    Future(test2).then((value) => print(value));
  }

  test2() async {
    print("start2");
    await Future.delayed(const Duration(seconds: 2));
    return "suc2";
  }

  @override
  Widget build(BuildContext context) => Center();
}
