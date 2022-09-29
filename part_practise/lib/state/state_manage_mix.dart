import 'package:flutter/material.dart';

/// 父、子各自管理状态
/// 父类管理了点击，子类管理了按压
class MyAppStateInMix extends StatefulWidget {
  const MyAppStateInMix({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppStateInMixState();
}

class _MyAppStateInMixState extends State<MyAppStateInMix> {
  bool _active = false;

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: "!!!!",
        home: Scaffold(
          appBar: AppBar(title: const Text("父、子各自管理状态")),
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

class _BorderWidget extends StatefulWidget {
  bool active;

  final ValueChanged<bool> onChange;

  _BorderWidget({required this.active, required this.onChange});

  onClick() {
    onChange(!active);
  }

  @override
  State<StatefulWidget> createState() => _BorderWidgetState();
}

/// 自己管理，手指按压时的状态
class _BorderWidgetState extends State<_BorderWidget> {
  bool _pressing = false;

  @override
  Widget build(BuildContext context) => GestureDetector(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              color: widget.active ? Colors.blue : Colors.blueGrey,
              border:
                  _pressing ? Border.all(color: Colors.red, width: 5.0) : null),
          child: Center(
            child: Text(
              widget.active ? "可用" : "不可用",
              style: const TextStyle(fontSize: 32.0, color: Colors.white),
            ),
          ),
        ),
        onTap: () {
          widget.onClick();
        },

        /// 按下时展示框框，抬起时取消框框
        onTapDown: (details) {
          setState(() {
            _pressing = true;
          });
        },
        onTapUp: (details) {
          setState(() {
            _pressing = false;
          });
        },
        // onTapCancel: () {
        //   setState(() {
        //     _pressing = false;
        //   });
        // },
      );
}
