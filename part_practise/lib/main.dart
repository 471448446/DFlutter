import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:part_practise/animation/animation_main.dart';
import 'package:part_practise/customwidget/customwidget_main.dart';
import 'package:part_practise/exception/exception_main.dart';
import 'package:part_practise/file/file_main.dart';
import 'package:part_practise/generated/l10n.dart';
import 'package:part_practise/i18/AppLocalizationsDelegate.dart';
import 'package:part_practise/i18/i18_main.dart';
import 'package:part_practise/l10n2/l10n.dart';
import 'package:part_practise/motionevent/motionevent_main.dart';
import 'package:part_practise/navigator/navigator_for_result_page.dart';
import 'package:part_practise/navigator/navigator_named_routine.dart';
import 'package:part_practise/res/res_main.dart';
import 'package:part_practise/state/state_manage_mix.dart';
import 'package:part_practise/state/state_manage_parent.dart';
import 'package:part_practise/state/state_manage_self.dart';
import 'package:part_practise/up/up.main.dart';
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
    //调用默认的onError
    defaultOnErr?.call(details);
    // reportErrorAndLog(details);
    //https://stackoverflow.com/questions/49707028/how-can-i-check-if-a-flutter-application-is-running-in-debug
    // if (kDebugMode) {
    //   // 测试环境直接打印
    //   FlutterError.dumpErrorToConsole(details);
    // } else {
    //   Zone.current.handleUncaughtError(details.exception, details.stack!);
    // }
  };
  // 以沙盒模式运行
  runZoned(() => runApp(const MyApp()),
      zoneSpecification: ZoneSpecification(
          print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
        // 只是打印
        collectLog(line);
        parent.print(zone, "Interceptor-->: $line");
      }, handleUncaughtError: (Zone self, ZoneDelegate parent, Zone zone,
              Object error, StackTrace stackTrace) {
        // 未被处理的异常，上报这个日志，打release的APK后，居然打印的行号没变，6啊
        reportErrorAndLog(makeDetails(error, stackTrace));
        // 打印到控制台
        parent.print(
            zone, "Interceptor-2->:" '${error.toString()} $stackTrace');
      }));
}

void collectLog(String line) {
  //收集日志
  // print("----------------begin crash");
  // print(line);
  // print("----------------end crash");
}

void reportErrorAndLog(FlutterErrorDetails details) {
  //上报错误和日志逻辑
  Fluttertoast.showToast(msg: "catch:${details.exception}");
  // Fluttertoast.showToast(msg: "catch:${details.stack}");
  var object = "reportErrorAndLog+:${details.stack}";
  print(object);
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
      localizationsDelegates: [
        // 本地化的代理类
        //为Material 组件库提供的本地化的字符串和其他值，它可以使Material 组件支持多语言
        GlobalMaterialLocalizations.delegate,
        //IOS主题
        GlobalCupertinoLocalizations.delegate,
        //定义组件默认的文本方向，从左到右或从右到左，这是因为有些语言的阅读习惯并不是从左到右，比如如阿拉伯语就是从右向左的。
        GlobalWidgetsLocalizations.delegate,
        // 第一种方式，完全自己写
        AppLocalizationsCustomDirectDelegate(),

        /// 上面时自己完全自定义时的写法，实际情况，2、3种方式，只需要写一个就行
        // 第二种方式使用intl，自动生成的
        S.delegate,
        // 第三种方式，系统默认自带功能
        MyAppLocalizations.delegate,
      ],
      // supportedLocales: const [
      //   //supportedLocales: 也接收一个Locale数组，表示我们的应用支持的语言列表，在本例中我们的应用只支持美国英语和中文简体两种语言
      //   // 美国英语
      //   Locale('en', 'US'),
      //   // 中文简体
      //   Locale('zh', 'CN'),
      // ],
      // supportedLocales: S.delegate.supportedLocales,
      supportedLocales: MyAppLocalizations.supportedLocales,
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
        appBar: AppBar(title: Builder(builder: (context) {
          return Text(
              "Hello ${AppLocalizationsCustomDirect.of(context).title} ${S.of(context).title}");
        })),
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
      // if (_scrollController.hasClients) {
      //
      // }
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(seconds: 2), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
      child: Scrollbar(
        child: SingleChildScrollView(
          // ios上这里抛出异常 The Scrollbar's ScrollController has no ScrollPosition attached.
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
              MotionEventDemoWidget(),
              AnimationDemoWidget(),
              CustomDefineWidgetDemoWidget(),
              FileHandleDemoWidget(),
              UpMoreDemoWidget(),
              I18DemoWidget(),
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
                  context, '命名路由', NamedRoutePage("我是参数")),
            ],
          )
        ],
      );
}
