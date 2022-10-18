import 'package:flutter/material.dart';
import 'package:part_practise/utils/ui.dart';
/// TabBar和TabBarView
class TabBarRoutePage extends SimplePageRoute {
  TabBarRoutePage({super.key}) : super('TabBar');

  @override
  Widget pageBody(BuildContext context) => _Pages();
}

class _Pages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PagesState();
}

class _PagesState extends State<_Pages> with SingleTickerProviderStateMixin {
  final titles = [
    const Tab(text: 'home', icon: Icon(Icons.home)),
    const Tab(text: 'explore', icon: Icon(Icons.explore)),
    const Tab(text: 'news', icon: Icon(Icons.newspaper))
  ];
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: titles.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          // 作者的demo里面是将TabBar放到的AppBar.bottom属性里面，就不用单独设置颜色了
          Container(
            color: Colors.blue,
            child: TabBar(
              tabs: titles,
              controller: tabController,
              indicatorColor: Colors.yellow,
            ),
          ),
          Expanded(
              // 使得TabBarView填充整个剩余空间
              child: TabBarView(
                  controller: tabController,
                  children: titles
                      .map((e) => KeepAliveWrapper(
                              child: Container(
                            alignment: Alignment.center,
                            child: Text(e.text!),
                          )))
                      .toList()))
        ],
      );
}
