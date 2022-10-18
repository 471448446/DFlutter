import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///https://book.flutterchina.club/chapter2/flutter_router.html#_2-4-5-%E5%91%BD%E5%90%8D%E8%B7%AF%E7%94%B1
///所谓“命名路由”（Named Route）即有名字的路由，我们可以先给路由起一个名字，
///然后就可以通过路由名字直接打开新的路由了，这为路由管理带来了一种直观、简单的方式。
/// 如何申明并使用命名路由，就是一个map
/// 如何传递参数，
class NamedRoutePage extends StatelessWidget {
  // 传递的参数
  var name = "";

  NamedRoutePage(this.name, {super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        // 页面支持的路由都放在这个map里面
        ///看起来只有在第一个页面注册才行，中途注册的用不了，垃圾
        ///The application's top-level routing table. 注释上也说了是top-level
        routes: {"route_test_01": (context) => _Test01Page()},
        home: Scaffold(
          appBar: AppBar(
            title: const Text("路由表管理页面"),
          ),
          body: Center(
            child: TextButton(
              onPressed: () {
                // 通过关键字启动新页面
                /// 这里启动会报错，找不到route
                Navigator.of(context, rootNavigator: true)
                    .pushNamed("route_test_01", arguments: "张三");
              },
              child: Text("点击启动新页面\n传递的参数：$name"),
            ),
          ),
        ),
      );
}

class _Test01Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 获取传递的参数
    var args = ModalRoute.of(context)?.settings.arguments;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("测试页面01"),
        ),
        body: Center(
          child: Text("测试页面，传递的数据: ${args ?? "没有串书籍"}"),
        ),
      ),
    );
  }
}
