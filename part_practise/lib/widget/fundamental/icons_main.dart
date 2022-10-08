import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:part_practise/utils/ui.dart';

/// https://book.flutterchina.club/chapter3/img_and_icon.html
/// icon可以减少安装包的size
class IconRoutePage extends SimplePageRoute {
   IconRoutePage({super.key}) : super('Icon Demo');

  @override
  Widget pageBody() {
    String icons = "";
// accessible: 0xe03e
    icons += "\uE03e";
// error:  0xe237
    icons += " \uE237";
// fingerprint: 0xe287
    icons += " \uE287";

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          icons,
          style: const TextStyle(
            fontFamily: "MaterialIcons",
            fontSize: 24.0,
            color: Colors.green,
          ),
        ),
        const Icon(Icons.accessible, color: Colors.green),
        const Icon(Icons.error, color: Colors.green),
        const Icon(Icons.fingerprint, color: Colors.green),
      ],
    );
  }
}
