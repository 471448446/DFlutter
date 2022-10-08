import 'package:flutter/material.dart';

///https://book.flutterchina.club/chapter3/text.htm
///fontSize：该属性和 Text 的textScaleFactor都用于控制字体大小。但是有两个主要区别：
///* fontSize可以精确指定字体大小，而textScaleFactor只能通过缩放比例来控制。
///* textScaleFactor主要是用于系统字体大小设置改变时对 Flutter 应用字体进行全局调整，而fontSize通常用于单个文本，字体大小不会跟随系统字体大小变化
///
/// Text 的所有文本内容只能按同一种样式，如果我们需要对一个 Text 内容的不同部分按照不同的样式显示，这时就可以使用TextSpan，它代表文本的一个“片段”
/// DefaultTextStyle: 在 Widget 树中，文本的样式默认是可以被继承的（子类文本类组件未指定具体样式时可以使用 Widget 树中父级设置的默认样式），
/// 因此，如果在 Widget 树的某一个节点处设置一个默认的文本样式，那么该节点的子树中所有文本都会默认使用这个样式，而DefaultTextStyle正是用于设置默认文本样式的

class TextRoutePage extends StatelessWidget {
  const TextRoutePage({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: "Text Demo",
        home: Scaffold(
          appBar: AppBar(title: const Text("Text Demo")),
          body: Column(
            children: [
              const Text('普通文本'),
              const Divider(
                height: 1,
                color: Colors.grey,
              ),
              const Text(
                '普通文本普通文本普通文本普通文本普通文本普通文本普通文本普通文本',
                textAlign: TextAlign.right,
              ),
              const Divider(
                height: 1,
                color: Colors.grey,
              ),
              const Text(
                '普通文本缩放',
                textScaleFactor: 1.5,
              ),
              const Divider(
                height: 1,
                color: Colors.grey,
              ),
              const Text(
                '有可能显示不下，有可能显示不下，有可能显示不下，有可能显示不下，有可能显示不下，',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const Divider(
                height: 1,
                color: Colors.grey,
              ),
              Text(
                "Hello World!",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18.0,
                    //该属性用于指定行高，但它并不是一个绝对值，而是一个因子，具体的行高等于fontSize*height。
                    height: 1.4,
                    //由于不同平台默认支持的字体集不同，所以在手动指定字体时一定要先在不同平台测试一下。
                    fontFamily: "Courier",
                    // 背景
                    // 操作符，直接访问对象的属性
                    background: Paint()..color = Colors.yellow,
                    // 在底部绘制线条
                    decoration: TextDecoration.underline,
                    // 绘制的线条颜色
                    decorationColor: Colors.red,
                    // 绘制的线程粗细
                    decorationThickness: 2.0,
                    // 绘制的线是虚线
                    decorationStyle: TextDecorationStyle.dashed),
              ),
              const Divider(
                height: 1,
                color: Colors.grey,
              ),
              const Text.rich(TextSpan(children: [
                TextSpan(text: "Home: "),
                TextSpan(
                    text: "https://flutterchina.club",
                    style: TextStyle(color: Colors.blue),
                    recognizer: null // 手势处理
                    ),
              ])),
              const Divider(
                height: 1,
                color: Colors.grey,
              ),
              DefaultTextStyle(
                //1.设置文本默认样式
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.start,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text("hello world"),
                    Text("I am Jack"),
                    Text(
                      "I am Jack",
                      style: TextStyle(
                          inherit: false, //2.不继承默认样式
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 1,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      );
}
