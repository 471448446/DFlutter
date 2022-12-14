import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Startup Name Generator',
        // 测试数据
        // home: Scaffold(
        //   appBar: AppBar(
        //     title: const Text("Welcome to Flutter Title"),
        //   ),
        //   body: const Center(
        //     // 直接显示
        //     // child: Text(
        //     //     // 'Hello World'
        //     //     wordPair.asPascalCase),
        //     child: RandomWordsWidget(),
        //   ),
        // ),
        theme: ThemeData(primaryColor: Colors.red),
        home: RandomWordsWidget());
  }
}

/// 这是一个widget，带有状态
/// Stateless widgets 是不可变的, 这意味着它们的属性不能改变 - 所有的值都是最终的.
/// Stateful widgets 持有的状态可能在widget生命周期中发生变化. 实现一个 stateful widget 至少需要两个类:
/// 1. 一个 StatefulWidget类。
/// 2. 一个 State类。 StatefulWidget类本身是不变的，但是 State类在widget生命周期中始终存在.
class RandomWordsWidget extends StatefulWidget {
  const RandomWordsWidget({super.key});

  @override
  State<StatefulWidget> createState() => RandomWordState();
}

class RandomWordState extends State<RandomWordsWidget> {
  final suggestions = <WordPair>[];
  final biggerFont = const TextStyle(fontSize: 18.0);

  final saved = Set<WordPair>();

  // 测试数据
  // @override
  // Widget build(BuildContext context) {
  //   // 生成一个widget
  //   final wordPair = WordPair.random();
  //   return Text(wordPair.asPascalCase);
  // }

  /// 这里将Scaffold写在这里，是为了方便导航的时候，获取已经保存的word数据
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Welcome to Flutter Title"),
          actions: [
            IconButton(onPressed: onPushSaved, icon: const Icon(Icons.list))
          ],
        ),
        body: buildSuggests(),
      );

  void onPushSaved() {
    // 导航到下一个路由
    ///新页面的内容在在MaterialPageRoute的builder属性中构建，builder是一个匿名函数。
    /// 添加Navigator.push调用，这会使路由入栈（以后路由入栈均指推入到导航管理器的栈）
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      final tiles = saved.map((e) => ListTile(
            title: Text(
              e.asPascalCase,
              style: biggerFont,
            ),
          ));
      // 每行添加一个分割线
      final divided =
          ListTile.divideTiles(context: context, tiles: tiles).toList();
      return Scaffold(
        appBar: AppBar(title: const Text("Saved words")),
        body: ListView(
          children: divided,
        ),
      );
    }));
  }

  Widget buildSuggests() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        // 在每一列之前，添加一个1像素高的分隔线widget
        if (i.isOdd) return const Divider();

        // 语法 "i ~/ 2" 表示i除以2，但返回值是整形（向下取整），比如i为：1, 2, 3, 4, 5
        // 时，结果为0, 1, 1, 2, 2， 这可以计算出ListView中减去分隔线后的实际单词对数量
        final index = i ~/ 2;
        // 如果是建议列表中最后一个单词对
        if (index >= suggestions.length) {
          // ...接着再生成10个单词对，然后添加到建议列表
          suggestions.addAll(generateWordPairs().take(10));
        }

        return buildRow(suggestions[index]);
      },
    );
  }

  Widget buildRow(WordPair pair) {
    final alreadySave = saved.contains(pair);
    // return Text(
    //   pair.asPascalCase,
    //   style: biggerFont,
    // );
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: biggerFont,
      ),
      trailing: Icon(
        alreadySave ? Icons.favorite : Icons.favorite_border,
        color: alreadySave ? Colors.red : null,
      ),
      onTap: () {
        // 在Flutter的响应式风格的框架中，调用setState() 会为State对象触发build()方法，从而导致对UI的更新
        setState(() {
          if (alreadySave) {
            saved.remove(pair);
          } else {
            saved.add(pair);
          }
        });
      },
    );
  }
}
