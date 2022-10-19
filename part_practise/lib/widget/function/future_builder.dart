import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:part_practise/utils/ui.dart';

class FutureBuilderRoutePage extends SimplePageRoute {
  FutureBuilderRoutePage() : super('异步刷新之FutureBuilder');

  Future<String> mockNetWork() async {
    return Future.delayed(const Duration(seconds: 3), () {
      return "网络数据获取成功";
    });
  }

  @override
  Widget pageBody(BuildContext context) => Center(
        child: Center(
          child: FutureBuilder<String>(
            future: mockNetWork(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              // builder内部会多次调用
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else {
                    return Text("Response: ${snapshot.data}");
                  }
                case ConnectionState.waiting:
                default:
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    Fluttertoast.showToast(msg: "开始请求网络数据，请稍后");
                  }
                  print("loading状态：${snapshot.connectionState}");
                  return const CircularProgressIndicator();
              }
            },
          ),
        ),
      );
}
