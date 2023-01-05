import 'package:flutter/cupertino.dart';
import 'package:part_practise/file/JsonConvertRoutePage.dart';
import 'package:part_practise/file/http_hell0.dart';
import 'package:part_practise/file/websocket_hello.dart';
import 'package:part_practise/utils/ui.dart';

import 'file_hello.dart';

/// 自定义组件
class FileHandleDemoWidget extends StatelessWidget {
  const FileHandleDemoWidget({super.key});

  @override
  Widget build(BuildContext context) => Column(children: [
        const TextTitleWidget("文件操作"),
        Wrap(
            spacing: 1.0, // 主轴(水平)方向间距
            runSpacing: 1.0, // 纵轴（垂直）方向间距
            alignment: WrapAlignment.start, //沿主轴方向居中
            children: [
              TextEntranceWidget.createEntranceAndWait(
                  context, "文件操作", FileHelloRoutePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, "网络请求", HttpHelloRoutePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, "Websocket", WebSocketHelloRoutePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, "JSON格式转换", JsonConvertRoutePage()),

              ///todo 更多
            ])
      ]);
}
