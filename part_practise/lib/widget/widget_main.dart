import 'package:flutter/cupertino.dart';
import 'package:part_practise/utils/ui.dart';
import 'package:part_practise/widget/fundamental/button_main.dart';
import 'package:part_practise/widget/fundamental/checkbox_main.dart';
import 'package:part_practise/widget/fundamental/icons_main.dart';
import 'package:part_practise/widget/fundamental/input_form_main.dart';
import 'package:part_practise/widget/fundamental/input_main.dart';
import 'package:part_practise/widget/fundamental/input_focus_main.dart';
import 'package:part_practise/widget/fundamental/progressbar_main.dart';
import 'package:part_practise/widget/fundamental/text_main.dart';
import 'package:part_practise/widget/fundamental/image_main.dart';

/// 一些UI控件的演示
class DemoWidget extends StatelessWidget {
  const DemoWidget({super.key});

  @override
  Widget build(BuildContext context) => Column(children: [
        const TextTitleWidget("Widget"),
        Wrap(
            spacing: 1.0, // 主轴(水平)方向间距
            runSpacing: 1.0, // 纵轴（垂直）方向间距
            alignment: WrapAlignment.start, //沿主轴方向居中
            children: [
              TextEntranceWidget.createEntranceAndWait(
                  context, "Text", const TextRoutePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, "Button", const ButtonRoutePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, "Image", const ImageRoutePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, "Icon", IconRoutePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, "CheckBox", CheckBoxRoutePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, "Input", InputRoutePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, "Input Focus", TextFocusRoutePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, "Input Form", InputFormRoutePage()),
              TextEntranceWidget.createEntranceAndWait(
                  context, "ProgressBar",ProgressBarRoutePage()),
            ])
      ]);
}
