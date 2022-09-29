import 'package:flutter/material.dart';

/// 父类管理子类
/// 父类_MyAppStateInParentState管理按压，子类不需要管理状态是一个StatelessWidget组件
class MyAppStateInParent extends StatefulWidget {
  const MyAppStateInParent({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppStateInParentState();
}

class _MyAppStateInParentState extends State<MyAppStateInParent> {
  bool _active = false;

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: "!!!!",
        home: Scaffold(
          appBar: AppBar(title: const Text("父类管理状态")),
          body: _BorderWidget(
            active: _active,

            /// onChange的实现者，一个匿名函数
            onChange: (ch) {
              setState(() {
                _active = ch;
              });
            },
          ),
        ),
      );
}

class _BorderWidget extends StatelessWidget {
  bool active;

  final ValueChanged<bool> onChange;

  _BorderWidget({required this.active, required this.onChange});

  onClick() {
    /// 因为_BorderWidget 本身的字段active在构造函数处，是引用的父类的_active，
    /// 所以这里每次取反，通知父类来修改
    /// 而我自己引用的父类变量，父类变了，我就变化了
    onChange(!active);
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration:
              BoxDecoration(color: active ? Colors.blue : Colors.blueGrey),
          child: Center(
            child: Text(
              active ? "可用" : "不可用",
              style: const TextStyle(fontSize: 32.0, color: Colors.white),
            ),
          ),
        ),
        onTap: () {
          onClick();
        },
      );
}
