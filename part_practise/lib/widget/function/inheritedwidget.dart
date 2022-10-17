import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:part_practise/utils/ui.dart';

/// 在子widget中共享数据，这里在最顶层的数据中保存了信息
/// 子widget通过context来获取
class InheritedWidgetRoutePage extends SimplePageRoute {
  InheritedWidgetRoutePage({super.key}) : super('InheritedWidget');

  @override
  Widget pageBody() => _Pages();
}

/// 这里的Stateful 是因为，页面有个点击按钮，点击后，页面要刷新
class _Pages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PagesState();
}

class _PagesState extends State<_Pages> {
  int count = 0;

  @override
  Widget build(BuildContext context) => Center(
        child: _SharedWidget(
          //最顶层，一个共享数据
          data: count,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: _TestWidget(), //子widget中依赖ShareDataWidget
              ),
              ElevatedButton(
                child: const Text("Increment"),
                //每点击一次，将count自增，然后重新build,ShareDataWidget的data将被更新
                onPressed: () => setState(() => ++count),
              )
            ],
          ),
        ),
      );
}

/// 这个是提供共享数据的widget
class _SharedWidget extends InheritedWidget {
  const _SharedWidget({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);
  final int data; //需要在子树中共享的数据，保存点击次数

  //定义一个便捷方法，方便子树中的widget获取共享数据
  static _SharedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_SharedWidget>();
  }

  //该回调决定当data发生变化时，是否通知子树中依赖data的Widget重新build
  @override
  bool updateShouldNotify(_SharedWidget old) {
    return old.data != data;
  }
}

class _TestWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<_TestWidget> {
  @override
  Widget build(BuildContext context) =>
      //使用InheritedWidget中的共享数据，因为使用了，所以就发生了依赖。
      // 这样在InheritedWidget中数据发生改变时，就会调用didChangeDependencies()
      Text("${_SharedWidget.of(context)?.data}");

  @override //下文会详细介绍。
  void didChangeDependencies() {
    super.didChangeDependencies();
    //父或祖先widget中的InheritedWidget改变(updateShouldNotify返回true)时会被调用。
    //如果build中没有依赖InheritedWidget，则此回调不会被调用。
    print("Dependencies change");
  }
}
