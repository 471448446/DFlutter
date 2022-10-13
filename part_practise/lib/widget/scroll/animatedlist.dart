import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:part_practise/utils/ui.dart';

class AnimatedListeRoutePage extends SimplePageRoute {
  AnimatedListeRoutePage() : super('AnimatedList');

  @override
  Widget pageBody() => _Pages();
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
              padding: const EdgeInsets.all(10),
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
    datas.removeAt(index);
    globalKey.currentState?.removeItem(index, (context, animation) => null);
  }
}
