import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
/// Material 组件库中提供了多种按钮组件如ElevatedButton、TextButton、OutlineButton等，
/// 它们都是直接或间接对RawMaterialButton组件的包装定制，所以他们大多数属性都和RawMaterialButton一样。
///
/// ElevatedButton 即"漂浮"按钮，它默认带有阴影和灰色背景。按下后，阴影会变大
/// TextButton即文本按钮，默认背景透明并不带阴影。按下后，会有背景色，
/// OutlineButton默认有一个边框，不带阴影且背景透明。按下后，边框颜色会变亮、同时出现背景和阴影(较弱)，
/// IconButton是一个可点击的Icon，不包括文字，默认没有背景，点击后会出现背景
class ButtonRoutePage extends StatelessWidget {
  const ButtonRoutePage({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
      title: "Button Demo",
      home: Scaffold(
          appBar: AppBar(title: const Text("Button Demo")),
          body: Column(children: [
            ElevatedButton(
                onPressed: () {
                  Fluttertoast.showToast(msg: 'click');
                },
                child: const Text('漂浮按钮')),
            TextButton(
              child: const Text("文本按钮"),
              onPressed: () {
                Fluttertoast.showToast(msg: 'click');
              },
            ),
            OutlinedButton(
              child: const Text("带边框的按钮"),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.thumb_up),
              onPressed: () {},
            ),
            // const Divider(
            //   height: 1,
            // ),
            /// 这些也可以带图标
            ElevatedButton.icon(
              icon: const Icon(Icons.send),
              label: const Text("发送"),
              onPressed: () {},
            ),
            OutlinedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text("添加"),
              onPressed: () {},
            ),
            TextButton.icon(
              icon: const Icon(Icons.info),
              label: const Text("详情"),
              onPressed: () {},
            ),
          ])));
}
