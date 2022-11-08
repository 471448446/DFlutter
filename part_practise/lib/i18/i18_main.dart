import 'package:flutter/material.dart';
import 'package:part_practise/generated/l10n.dart';
import 'package:part_practise/i18/AppLocalizationsDelegate.dart';
import 'package:part_practise/l10n2/l10n.dart';
import 'package:part_practise/utils/ui.dart';

class I18DemoWidget extends StatelessWidget {
  const I18DemoWidget({super.key});

  @override
  Widget build(BuildContext context) => Column(children: [
        const TextTitleWidget("国际化"),
        Wrap(
            spacing: 1.0, // 主轴(水平)方向间距
            runSpacing: 1.0, // 纵轴（垂直）方向间距
            alignment: WrapAlignment.start, //沿主轴方向居中
            children: [
              Text(
                "国际化字符串： "
                "\n${AppLocalizationsCustomDirect.of(context).title} "
                "\n ${S.of(context).askChoice("张三", "zhangsan")} "
                "\n ${S.of(context).customDateFormat(DateTime.now())}"
                "\n ${context.l10n.appName}",
              )
            ])
      ]);
}
