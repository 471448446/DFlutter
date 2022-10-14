import 'package:flutter/material.dart';
import 'package:part_practise/utils/ui.dart';

/// 结合常用的底部导航，和TabBar。
/// todo TabBar无法连续滑动到下一个PageView
/// https://stackoverflow.com/questions/56907970/is-it-possible-to-swipe-from-an-tabbarview-content-area-to-an-adjacent-pageview
class PageViewAndBottomNavigationBarRoutePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => _Pages();
}

class _Pages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PagesState();
}

class _PagesState extends State<_Pages> {
  var selectIndex = 0;
  late PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: selectIndex);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('PageViewAndBottomNavigationBar'),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectIndex,
          onTap: (index) {
            setState(() {
              selectIndex = index;
              controller.jumpToPage(selectIndex);
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.explore), label: 'Explore'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
        body: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() {
              selectIndex = index;
            });
          },
          children: [
            _HomePage(),
            const Center(
              child: Text('Explore'),
            ),
            const Center(
              child: Text('Profile'),
            ),
          ],
        ),
      );
}

class _HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage>
    with SingleTickerProviderStateMixin {
  final titles = [
    const Tab(
      text: 'air',
    ),
    const Tab(
      text: 'rocket',
    ),
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
                  children: titles.map((e) {
                    return KeepAliveWrapper(
                        child: Container(
                      alignment: Alignment.center,
                      child: Text(e.text!),
                    ));
                  }).toList()))
        ],
      );
}
