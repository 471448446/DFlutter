import 'package:flutter/material.dart';

/// widget 自己管理状态
class MyAppStateInSelf extends StatelessWidget {
  const MyAppStateInSelf({super.key});

  @override
  Widget build(BuildContext context) => const _MyWidget();
}

/// 下划线，表示，私有
class _MyWidget extends StatefulWidget {
  const _MyWidget();

  @override
  State<StatefulWidget> createState() => _MyAppSelfState();
}

class _MyAppSelfState extends State<_MyWidget> {
  bool _active = false;

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: "!!!",
        home: Scaffold(
          appBar: AppBar(
            title: const Text("自己管理State"),
          ),
          body: GestureDetector(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration:
                  BoxDecoration(color: _active ? Colors.blue : Colors.blueGrey),
              child: Center(
                child: Text(
                  _active ? "可用" : "不可用",
                  style: const TextStyle(fontSize: 32.0, color: Colors.white),
                ),
              ),
            ),
            onTap: () {
              setState(() {
                _active = !_active;
              });
            },
          ),
        ),
      );
}
