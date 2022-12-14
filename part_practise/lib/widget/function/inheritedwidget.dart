import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:part_practise/utils/ui.dart';

/// 在子widget中共享数据，这里在最顶层的数据中保存了信息
/// 子widget通过context来获取
class InheritedWidgetRoutePage extends SimplePageRoute {
  InheritedWidgetRoutePage({super.key}) : super('InheritedWidget');

  @override
  Widget pageBody(BuildContext context) => _Pages();
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
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),

                /// 这里引用的context是 ` Widget build(BuildContext context) => Center(`函数的参数中的context
                /// 所以是无法找到_SharedWidget的，因为_SharedWidget是在函数里面生成的
                /// 这里其找到父类的Context就可以了，但是无法直接引用，解决方式就是_TestWidget写成单独的类
                /// 或者使用Builder
                /// Builder(builder(context){
                ///             return Text("${_SharedWidget.of(context)?.data}");
                ///         })
                ///
                child: Text(
                    "${_SharedWidget.of(context)?.data}"), //子widget中依赖ShareDataWidget
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

  // _SharedWidget(
  //     {required this.data, required super.child});

  // 需要在子树中共享的数据，保存点击次数
  final int data;

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
