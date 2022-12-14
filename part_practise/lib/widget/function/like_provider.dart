import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:part_practise/utils/ui.dart';

///我们需要实现一个显示购物车中所有商品总价的功能
///一开始一直失败，是因为，在ChangeNotifierProvider.of()方法处，没有传递具体的泛型类型，
///导致内部调用dependOnInheritedWidgetOfExactType<InheritedProvider<T>>中的T是 dynamic。所以无法获取到InheritedWidget。
///既要像这样调用：ChangeNotifierProvider.of<CartModel>()，指定具体的泛型类型
///PS：通过在调用ChangeNotifierProvider.of方法处加断点，打印context，发现没有问题，发现是传进去的泛型不对，shit
///以及：https://blog.csdn.net/petterp/article/details/111770747 使用Builder的原因，指是为了能在当代你的context上找到InheritedWidget
///一个Widget（StatelessWidget、StatefulWidget）被渲染后对应一个Element，而Element就是BuilderContext的子类
class LikeProviderRoutePage extends SimplePageRoute {
  LikeProviderRoutePage({super.key}) : super('模拟Provider');

  @override
  Widget pageBody(BuildContext context) => Center(
        child: ChangeNotifierProvider<CartModel>(
            data: CartModel(),
            child: Builder(
              builder: (context) {
                print("Column use Builder context is $context");
                return Column(
                  children: [
                    // 使用Builder，传递正确的Context
                    Builder(builder: (context) {
                      print(
                          "Column children Text use Builder context is $context");
                      return Text(
                          "总价:${ChangeNotifierProvider.of<CartModel>(context)?.allPrice}");
                    }),
                    // 这里不加也没问题，因为ChangeNotifierProvider的child地方以及加了Builder，
                    // 能够传递父类InheritedWidget的Context，否正传递的LikeProviderRoutePage的contxt
                    Text(
                        "总价:${ChangeNotifierProvider.of<CartModel>(context)?.allPrice}"),
                    //或者写一个单独的类也可以
                    TextTestWidget(),
                    Consumer<CartModel>(
                        builder: (context, data) =>
                            Text('总价使用Consumer:${data?.allPrice}')),
                    Builder(builder: (context) {
                      print(
                          "Column children ElevatedButton build context is $context");
                      return ElevatedButton(
                        onPressed: () {
                          print(
                              "Column children ElevatedButton click Builder context is $context");
                          // 默认自己也要刷新
                          // ChangeNotifierProvider.of<CartModel>(context)?.addGoods(Goods(20, "张三"));
                          // 优化后，自己不刷新
                          ChangeNotifierProvider.of<CartModel>(context,
                                  refresh: false)
                              ?.addGoods(Goods(20, "张三"));
                        },
                        child: const Text("增加商品"),
                      );
                    })
                  ],
                );
              },
            )),
      );
}

/// 如果不适用Builder，可以单独写一个类传递正确的context
/// 这里提现不出来，因为在最外层，ChangeNotifierProvider的child地方以及加了Builder，能正确传递Inherited的Context了。
class TextTestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("TextTest context is $context");
    return Text(
        "总价:${ChangeNotifierProvider.of<CartModel>(context)?.allPrice}");
  }
}
//
// class _Pages extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _PagesState();
// }
//
// class _PagesState extends State<_Pages> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: ChangeNotifierProvider<CartModel>(
//           data: CartModel(),
//           child: Builder(
//             builder: (context) {
//               return Column(
//                 children: [
//                   Builder(builder: (context) {
//                     return Text(
//                         "总价:${ChangeNotifierProvider.of(context).allPrice}");
//                   }),
//                   Builder(builder: (context) {
//                     print("ElevatedButton build");
//                     return MaterialButton(
//                       onPressed: () {
//                         ChangeNotifierProvider.of(context)
//                             .addGoods(Goods(20, "张三"));
//                       },
//                       child: const Text("增加商品"),
//                     );
//                   })
//                 ],
//               );
//             },
//           )),
//     );
//   }
// }

class Goods {
  // 价格
  double price;

  // 名称
  String name;

  Goods(this.price, this.name);
}

class CartModel extends ChangeNotifier {
  // 所有的商品
  final List<Goods> _lists = [];

  // 禁止改变购物车里的商品信息
  UnmodifiableListView<Goods> get allLists => UnmodifiableListView(_lists);

  // 购物车中的商品总价
  double get allPrice =>
      _lists.fold(0, (previousValue, element) => previousValue + element.price);

  addGoods(Goods goods) {
    _lists.add(goods);
    notifyListeners();
  }
}

///--------------------------------------------------------基础信息 start
/// 按照前面的例子，继承于InheritedWidget的widget，在子类里面可以共享数据
class InheritedProvider<T> extends InheritedWidget {
  final T data;

  InheritedProvider({super.key, required this.data, required super.child});

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    //在此简单返回true，则每次更新都会调用依赖其的子孙节点的`didChangeDependencies`。
    return true;
  }
}

/// 共享数据存放在T类型中，当数据发生变化时，调用ChangeNotifier的update放来通知Widget发生了变化，
/// 而在下一步中，ChangeNotifier的update方法绑定了setState方法，这样就会重新刷新Widget。
class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {
  final T data;
  final Widget child;

  // const ChangeNotifierProvider({required this.data, required this.child, super.key});
  const ChangeNotifierProvider(
      {required this.data, required this.child, super.key});

  //定义一个便捷方法，方便子树中的widget获取共享数据
  static T? of<T>(BuildContext context, {bool refresh = true}) {
    // final type = _typeOf<InheritedProvider<T>>();
    print("ChangeNotifierProvider of() context is $context T is $T");
    final provider = refresh
        ? context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>()
        : context
            .getElementForInheritedWidgetOfExactType<InheritedProvider<T>>()
            ?.widget as InheritedProvider<T>;
    print("ChangeNotifierProvider of() 获取到的provider: $provider");
    return provider?.data;
  }

  @override
  _ChangeNotifierProviderState<T> createState() =>
      _ChangeNotifierProviderState<T>();
}

///可以看到_ChangeNotifierProviderState类的主要作用就是监听到共享状态（model）改变时重新构建Widget树。
///注意，在_ChangeNotifierProviderState类中调用setState()方法，widget.child始终是同一个，
///所以执行build时，InheritedProvider的child引用的始终是同一个子widget，所以widget.child并不会重新build，
///这也就相当于对child进行了缓存！当然如果ChangeNotifierProvider父级Widget重新build时，则其传入的child便有可能会发生变化。
class _ChangeNotifierProviderState<T extends ChangeNotifier>
    extends State<ChangeNotifierProvider<T>> {
  void update() {
    //如果数据发生变化（model类调用了notifyListeners），重新构建InheritedProvider
    setState(() => {});
  }

  @override
  void didUpdateWidget(ChangeNotifierProvider<T> oldWidget) {
    //当Provider更新时，如果新旧数据不"=="，则解绑旧数据监听，同时添加新数据监听
    if (widget.data != oldWidget.data) {
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    // 给model添加监听器
    widget.data.addListener(update);
    super.initState();
  }

  @override
  void dispose() {
    // 移除model的监听器
    widget.data.removeListener(update);
    super.dispose();
  }

  ///[update]方法，里面调用了[setState]会刷新这个方法
  @override
  Widget build(BuildContext context) {
    return InheritedProvider<T>(
      data: widget.data,
      child: widget.child,
    );
  }
}

/// 所有需要使用共享数据的，直接用这个类包裹以下，
/// 1. 目的更明确
/// 2. 避免每次都ChangeNotifierProvider.of(context),模板代码
class Consumer<T> extends StatelessWidget {
  final Widget Function(BuildContext context, T? t) builder;

  const Consumer({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    var of = ChangeNotifierProvider.of<T>(context);
    return builder(context, of);
  }
}

///--------------------------------------------------------基础信息 end
