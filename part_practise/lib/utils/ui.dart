import 'package:flutter/material.dart';

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
  static VoidCallback _defaultOnClick(BuildContext context, Widget route) =>
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
    return createEntrance(context, text, _defaultOnClick(context, route));
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

abstract class SimplePageRoute extends StatelessWidget {
  final String pageTitle;
  late BuildContext context;

  SimplePageRoute(this.pageTitle, {super.key});

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return MaterialApp(
      title: pageTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(pageTitle),
        ),
        body: pageBody(),
      ),
    );
  }

  Widget pageBody();
}

class LayoutLogPrint<T> extends StatelessWidget {
  const LayoutLogPrint({
    Key? key,
    this.tag,
    required this.child,
  }) : super(key: key);

  final Widget child;
  final T? tag; //指定日志tag

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      // assert在编译release版本时会被去除
      assert(() {
        print('${tag ?? key ?? child}: $constraints');
        return true;
      }());
      return child;
    });
  }
}
