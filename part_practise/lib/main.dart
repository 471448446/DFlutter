import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:part_practise/exception/exception_main.dart';
import 'package:part_practise/navigator/navigator_for_result_page.dart';
import 'package:part_practise/navigator/navigator_named_routine.dart';
import 'package:part_practise/res/res_main.dart';
import 'package:part_practise/state/state_manage_mix.dart';
import 'package:part_practise/state/state_manage_parent.dart';
import 'package:part_practise/state/state_manage_self.dart';
import 'package:part_practise/utils/ui.dart';
import 'package:part_practise/widget/container_main.dart';
import 'package:part_practise/widget/function_main.dart';
import 'package:part_practise/widget/layout_main.dart';
import 'package:part_practise/widget/scroll_main.dart';
import 'package:part_practise/widget/widget_main.dart';

void main() {
  // runApp(const MyAppStateInMix());
  // 获取默认的错误处理
  var defaultOnErr = FlutterError.onError;
  // 重新设置默认的错误回调
  FlutterError.onError = (FlutterErrorDetails details) {
    defaultOnErr?.call(details);
    reportErrorAndLog(details);
  };
  // 以沙盒模式运行
  runZoned(() => runApp(const MyApp()),
      zoneSpecification: ZoneSpecification(
          print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
        collectLog(line);
        parent.print(zone, "Interceptor: $line");
      }, handleUncaughtError: (Zone self, ZoneDelegate parent, Zone zone,
              Object error, StackTrace stackTrace) {
        reportErrorAndLog(makeDetails(error, stackTrace));
        parent.print(zone, '${error.toString()} $stackTrace');
      }));
}

void collectLog(String line) {
  //收集日志
}

void reportErrorAndLog(FlutterErrorDetails details) {
  //上报错误和日志逻辑
  Fluttertoast.showToast(msg: details.exception.toString());
}

FlutterErrorDetails makeDetails(Object obj, StackTrace stack) {
  // 构建错误信息
  return FlutterErrorDetails(exception: obj, stack: stack);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text("Hello")),
        body: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  late ScrollController _scrollController;
  DateTime? _lastPressedAt; //上次点击时间

  MyHomePage({super.key}) {
    _scrollController = ScrollController();
    // 打开APP时，直接滚动到底部
    //https://stackoverflow.com/questions/61437549/flutter-how-to-automaticallly-scroll-to-end-of-singlechildscrollview
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(seconds: 2), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
      child: Scrollbar(
        child: SingleChildScrollView(
          controller: _scrollController,
          // 滑动展示显示不完的数据
          child: Column(
            children: const [
              _StateEnterWidget(),
              _NavigatorEntranceWidget(),
              ResourceWidget(),
              ErrWidget(),
              DemoWidget(),
              LayoutDemoWidget(),
              ContainerDemoWidget(),
              ScrollDemoWidget(),
              FunctionDemoWidget(),
            ],
          ),
        ),
      ),
      onWillPop: () async {
        if (_lastPressedAt == null ||
            DateTime.now().difference(_lastPressedAt!) >
                const Duration(seconds: 1)) {
          //两次点击间隔超过1秒则重新计时
          _lastPressedAt = DateTime.now();
          Fluttertoast.showToast(msg: '再次点击,退出APP!');
          return false;
        }
        return true;
      });
}

/// 状态管理
class _StateEnterWidget extends StatelessWidget {
  const _StateEnterWidget({super.key});

  createEntrance(BuildContext context, String text, Widget route) {
    return TextButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return route;
          }));
        },
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
          padding: const EdgeInsetsDirectional.all(3.0),
          margin: const EdgeInsetsDirectional.all(0),
          child: Text(text),
        ));
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const TextTitleWidget("State 管理"),
          Wrap(
            spacing: 0,
            runSpacing: 1,
            alignment: WrapAlignment.start,
            children: [
              createEntrance(context, "父类管理状态", const MyAppStateInParent()),
              createEntrance(context, "子类管理状态", const MyAppStateInSelf()),
              createEntrance(context, "父、子各自管理状态", const MyAppStateInMix()),
            ],
          )
        ],
      );
}

/// 导航
class _NavigatorEntranceWidget extends StatelessWidget {
  const _NavigatorEntranceWidget();

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const TextTitleWidget("Navigator路由"),
          Row(
            children: [
              TextEntranceWidget.createEntranceAndWait(
                  context, "startForResult", const DetailsPage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, '命名路由', const NamedRoutePage()),
            ],
          )
        ],
      );
}
