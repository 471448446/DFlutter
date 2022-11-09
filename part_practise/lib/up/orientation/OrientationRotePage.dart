import 'package:flutter/material.dart';
import 'package:part_practise/utils/ui.dart';

///[使用 Flutter 开发兼顾多种屏幕尺寸和旋转的应用](https://medium.com/flutter-community/developing-for-multiple-screen-sizes-and-orientations-in-flutter-fragments-in-flutter-a4c51b849434)
/// 总体思路是，大屏幕展示更多的信息，充分利用屏幕的剩余空间。
/// 1. 利用OrientationBuilder来感知屏幕发生变化，
/// 2. 判断当前是何种屏幕状态，
/// 3. 进而返回不同的布局
class OrientationRoutePage extends SimplePageRoute {
  OrientationRoutePage({super.key}) : super('处理屏幕旋转');

  @override
  Widget pageBody(BuildContext context) => OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
        if (Orientation.landscape == orientation) {
          return _horizontal();
        } else {
          return _vertical();
        }
      });

  Widget _horizontal() => _HorizontalPage(
        orientationRoutePage: this,
      );

  /// 列表+点击item后，新开一个页面展示详情
  Widget _vertical() => _listPages((index) {
        Navigator.push(
          context,
          PageRouteBuilder(
              transitionDuration: const Duration(microseconds: 800),
              pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) {
                return FadeTransition(
                  opacity: animation,
                  child: _DetailsRoutePages(
                    detailId: index,
                  ),
                );
              }),
        );
      });

  _listPages(void Function(int) onClick) => ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: TextButton(
              onPressed: () {
                // 这里只是为了方便，传递的index，实际情况因该是传列表里面的bean
                onClick(index);
              },
              child: Text("$index")),
        );
      });
}

class _HorizontalPage extends StatefulWidget {
  final OrientationRoutePage orientationRoutePage;

  _HorizontalPage({required this.orientationRoutePage});

  @override
  State<StatefulWidget> createState() => _HorizontalPageState();
}

class _HorizontalPageState extends State<_HorizontalPage> {
  /// 当前展示的页数
  int showIndex = -1;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            flex: 1,
            child: widget.orientationRoutePage._listPages(
              (index) {
                setState(() {
                  showIndex = index;
                });
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Theme.of(context).primaryColor,
              child: Center(
                child: Text(
                  "$showIndex",
                  style: const TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
            ),
          )
        ],
      );
}

class _DetailsRoutePages extends SimplePageRoute {
  final int detailId;

  _DetailsRoutePages({required this.detailId}) : super("详情");

  @override
  Widget pageBody(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Center(
        child: Text(
          "$detailId",
          style: const TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
    );
  }
}
