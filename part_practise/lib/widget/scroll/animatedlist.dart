import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:part_practise/utils/ui.dart';

/// 做动画的列表
class AnimatedListeRoutePage extends SimplePageRoute {
  AnimatedListeRoutePage() : super('AnimatedList');

  @override
  Widget pageBody(BuildContext context) => _Pages();
}

class _Pages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PagesState();
}

class _PagesState extends State<_Pages> {
  List<String> datas = [];
  final globalKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 5; i++) {
      datas.add(i.toString());
    }
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          AnimatedList(
            key: globalKey,
            initialItemCount: datas.length,
            itemBuilder: (
              BuildContext context,
              int index,
              Animation<double> animation,
            ) {
              //添加列表项时会执行渐显动画
              return FadeTransition(
                opacity: animation,
                child: listItem(index),
              );
            },
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(60),
              child: FloatingActionButton(
                onPressed: () {
                  addMoreDate();
                },
                child: const Icon(Icons.add),
              ),
            ),
          )
        ],
      );

  Widget listItem(int index) {
    var bean = datas[index];
    return ListTile(
        title: Text(bean),
        trailing: IconButton(
            onPressed: () {
              deleteData(index);
            },
            icon: const Icon(Icons.delete)));
  }

  void addMoreDate() {
    // setState(() {
    //   datas.add(datas.length.toString());
    // });
    datas.add(datas.length.toString());
    globalKey.currentState?.insertItem(datas.length - 1);
  }

  void deleteData(int index) {
    // setState(() {
    //   datas.removeAt(index);
    // });
    globalKey.currentState?.removeItem(index, (context, animation) {
      var listViewItem = listItem(index);
      print('删除 ${datas[index]}');
      // 真实的移除数据
      datas.removeAt(index);
      return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            //让透明度变化的更快一些
            curve: const Interval(0.5, 1.0),
          ),
          // 不断缩小列表项的高度
          child: SizeTransition(
            sizeFactor: animation,
            axisAlignment: 0.0,
            child: listViewItem,
          ));
    });
  }
}
