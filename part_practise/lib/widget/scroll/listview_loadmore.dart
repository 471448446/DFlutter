import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:part_practise/utils/ui.dart';

/// 显示一个加载更多
class ListViewLoadMoreRoutePage extends SimplePageRoute {
  ListViewLoadMoreRoutePage({super.key}) : super('ListView loadMore');

  /// 这里无法剧中[pageBody0]
  /// 所以使用了Center，这是从父布局的方式来处理 [pageBody1]
  /// 也可以从内部 [pageBody2]
  @override
  Widget pageBody(BuildContext context) => Column(
        children: [
          const Text('这是一个表头，使用Expanded扩充下面的ListView'),
          Expanded(child: _LoadMoreListView())
        ],
      );
}

class _LoadMoreListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoadMoreListViewState();
}

class _LoadMoreListViewState extends State {
  final List<String> words = ['last not show in page'];

  final divider2 = const Divider(
    color: Colors.blue,
  );

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   // 初始化先准备点数据
  //   loadMore();
  // }

  @override
  Widget build(BuildContext context) => ListView.separated(
      itemCount: words.length,
      separatorBuilder: (BuildContext context, int index) {
        return divider2;
      },
      itemBuilder: (context, index) {
        if (index == words.length - 1) {
          // 最后一个了
          if (words.length > 49) {
            //假设只加载100个
            return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                "没有更多了",
                style: TextStyle(color: Colors.grey),
              ),
            );
          } else {
            loadMore();
            return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16.0),
              child: const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  )),
            );
          }
        }
        return ListTile(title: Text("$index :${words[index]}"));
      });

  void loadMore() {
    Future.delayed(const Duration(seconds: 2)).then((value) => {
          setState(() {
            var loaded = generateWordPairs().take(20).map((e) => e.asLowerCase);
            words.insertAll(words.length - 1, loaded);
            // words.addAll(loaded);
          })
        });
  }
}
