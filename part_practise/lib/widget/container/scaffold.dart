import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:part_practise/utils/ui.dart';

/// https://book.flutterchina.club/chapter5/material_scaffold.html
class ScaffoldRoutePage extends StatefulWidget {
  const ScaffoldRoutePage({super.key});

  @override
  State<StatefulWidget> createState() => _ScaffoldRoutePageState();
}

class _ScaffoldRoutePageState extends State<ScaffoldRoutePage> {
  int selectIndex = 0;
  final pages = [
    // 这里打印了日志，每次点击底部的导航栏，都会打印，说明widget被重绘了，因为这里是stateful
    const LayoutLogPrint(
        tag: 'PrintScaffold', child: Center(child: Text('Home'))),
    const LayoutLogPrint(
        tag: 'PrintScaffold', child: Center(child: Text('More'))),
    const LayoutLogPrint(
        tag: 'PrintScaffold', child: Center(child: Text('Profile'))),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('一个Drawer+底部导航栏'),
          // 自定义导航栏的图标
          leading: Builder(builder: (context) {
            return IconButton(
              icon: const Icon(Icons.dashboard, color: Colors.white), //自定义图标
              onPressed: () {
                // 打开抽屉菜单
                Scaffold.of(context).openDrawer();
              },
            );
          }),
          actions: [
            IconButton(
                onPressed: () {
                  Fluttertoast.showToast(msg: 'click');
                },
                icon: const Icon(Icons.more))
          ],
        ),
        drawer: _MyDrawer(),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: selectIndex,
            fixedColor: Colors.blue,
            onTap: (int select) {
              setState(() {
                selectIndex = select;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '主页',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.factory_outlined),
                label: '更多',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: '个人',
              ),
            ]),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('add more')));
          },
        ),
        body: pages[selectIndex],
      );

  providepageBody(BuildContext context) => Column(
        children: [
          BottomAppBar(
            color: Colors.white,
            shape: const CircularNotchedRectangle(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.home)),
                const SizedBox(),
                IconButton(onPressed: () {}, icon: const Icon(Icons.business)),
              ],
            ),
          )
        ],
      );
}

class _MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Drawer(
        backgroundColor: Colors.white,
        elevation: 1,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        //MediaQuery.removePadding可以移除Drawer默认的一些留白（比如Drawer默认顶部会留和手机状态栏等高的留白）
        child: MediaQuery.removePadding(
            context: context,
            removeTop: true, //移除抽屉菜单顶部默认留白
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 38),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/icon.png'),
                      const Text(
                        'Hello Drawer',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: const <Widget>[
                      ListTile(
                        leading: Icon(Icons.add),
                        title: Text('Add account'),
                      ),
                      ListTile(
                        leading: Icon(Icons.settings),
                        title: Text('Manage accounts'),
                      ),
                    ],
                  ),
                )
              ],
            )),
      );
}
