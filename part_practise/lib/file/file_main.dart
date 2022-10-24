import 'package:flutter/cupertino.dart';
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

              ///todo 更多
            ])
      ]);
}
