import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:part_practise/utils/ui.dart';

class StreamBuilderRoutePage extends SimplePageRoute {
  StreamBuilderRoutePage({super.key}) : super('异步刷新之StreamBuilder');

  Stream<int> counter() {
    return Stream.periodic(const Duration(seconds: 1), (i) {
      return i;
    });
  }

  @override
  Widget pageBody(BuildContext context) => Center(
        child: StreamBuilder<int>(
          //页面销毁时会自动unsubscribe
          stream: counter(), //
          //initialData: ,// a Stream<int> or null
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Text('没有Stream');
              case ConnectionState.waiting:
                return const Text('等待数据...');
              case ConnectionState.active:
                return Text('active: ${snapshot.data}');
              case ConnectionState.done:
                return const Text('Stream 已关闭');
            }
          },
        ),
      );
}
