import 'package:flutter/material.dart';

/// 假设这是一个商品详情页，进入页面需要传入参数，用户浏览后，返回数据给上一个页面
/// 模拟startActivityForResult()
class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: "!!!",
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: Scaffold(
          appBar: AppBar(title: const Text('启动新页面后，返回数据')),
          body: Center(
            child: Column(
              children: [
                const Text('点击按钮后，返回数据到上一个页面'),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, "我是返回值");
                    },
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.only(
                                left: 60, top: 10, right: 60, bottom: 10)),
                        // textStyle: MaterialStateProperty.all(
                        //     const TextStyle(fontSize: 18, color: Colors.black)),
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.focused) &&
                              !states.contains(MaterialState.pressed)) {
                            //获取焦点时的颜色
                            return Colors.blue;
                          } else if (states.contains(MaterialState.pressed)) {
                            //按下时的颜色
                            return Colors.deepPurple;
                          }
                          //默认状态使用灰色
                          return Colors.grey;
                        })),
                    child: const Text(
                      '确认',
                      style: TextStyle(fontSize: 18, color: Colors.red),
                    ))
              ],
            ),
          ),
        ),
      );
}
