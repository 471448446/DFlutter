import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:part_practise/navigator/navigator_for_result_page.dart';
import 'package:part_practise/navigator/navigator_named_routine.dart';
import 'package:part_practise/state/state_manage_mix.dart';
import 'package:part_practise/state/state_manage_parent.dart';
import 'package:part_practise/state/state_manage_self.dart';

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
        body: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: const [
          _StateEnterWidget(),
          _NavigatorEntranceWidget(),
          _ErrWidget()
        ],
      );
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
          Row(
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
          const TextTitleWidget("Navigator"),
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

/// 导航
class _ErrWidget extends StatelessWidget {
  const _ErrWidget();

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const TextTitleWidget("Handle Error"),
          Row(
            children: [
              TextEntranceWidget.createEntrance(context, "try-catch", () {
                try {
                  throw Exception("Test throw one exception!!!");
                } catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                }
              }),
              TextEntranceWidget.createEntrance(context, "框架捕获异常", () {
                throw Exception("Test throw one exception!!!");
              }),
              TextEntranceWidget.createEntrance(context, "异步异常", () {
                // 以下这种异步的异常，虽然使用try-catch，但是是无法捕获的
                try {
                  Future.delayed(Duration(seconds: 1)).then(
                      (e) => Future.error("Test throw one async exception!!!"));
                } catch (e) {
                  print(e);
                }
              }),
            ],
          )
        ],
      );
}

/// 标题文本
class TextTitleWidget extends Text {
  /// https://stackoverflow.com/questions/55635663/invalid-constant-value-using-variable-as-parameter
  /// 这里在构造函数处不能申明const
  // const TitleWidget(data, {super.key})
  //      : super(data, style: TextStyle(color: Colors.black, fontSize: 18.0));
  /// 这样是可以的都得是const
  const TextTitleWidget(data, {super.key})
      : super(data,
            style: const TextStyle(color: Colors.black, fontSize: 18.0));
}

/// 入口文本
class TextEntranceWidget extends Text {
  const TextEntranceWidget(super.data, {super.key})
      : super(style: const TextStyle(color: Colors.blue, fontSize: 14.0));

  /// 默认：打开路由的点击响应
  static VoidCallback defaultOnClick(BuildContext context, Widget route) =>
      () async {
        var result =
            await Navigator.push(context, MaterialPageRoute(builder: (context) {
          return route;
        }));
        print("路由返回数据 $result");
        if (null != result) {
          /// https://stackoverflow.com/questions/72667782/undefined-name-mounted
          /// The mounted property is only available in a StatefulWidget
          /// 这里获取不到State，也就获取不到mounted字段
          // if (!context.mounted) return;
          /// 这里不建议使用BuildContext,因为在异步代码中，可能context以及销毁，但是暂时不知怎么处理
          /// https://dart-lang.github.io/linter/lints/use_build_context_synchronously.html
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(result)));
        }
      };

  /// 一个入口按钮，并等待结果
  static createEntranceAndWait(BuildContext context, String text, Widget route,
      {VoidCallback? callback}) {
    return createEntrance(context, text, defaultOnClick(context, route));
  }

  static createEntrance(
      BuildContext context, String text, VoidCallback? callback) {
    return TextButton(
        onPressed: callback,
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
          padding: const EdgeInsetsDirectional.all(3.0),
          margin: const EdgeInsetsDirectional.all(0),
          child: TextEntranceWidget(text),
        ));
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Invoke "debug painting" (press "p" in the console, choose the
//           // "Toggle Debug Paint" action from the Flutter Inspector in Android
//           // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//           // to see the wireframe for each widget.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
