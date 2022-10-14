import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:part_practise/utils/ui.dart';

/// 跟ListView类似，不多他有布局实现者，gridDelegate
class GridViewRoutPage extends SimplePageRoute {
  var items = [];

  GridViewRoutPage({super.key}) : super('GridView') {
    items.add(const Icon(Icons.bike_scooter));
    items.add(const Icon(Icons.electric_bike));
    items.add(const Icon(Icons.motorcycle));
    items.add(const Icon(Icons.car_repair));
    items.add(const Icon(Icons.subway));
    items.add(const Icon(Icons.train));
    items.add(const Icon(Icons.airplanemode_active));
    items.add(const Icon(Icons.rocket));
  }

  @override
  Widget pageBody() => Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
            gridDelegate: sliverGridDelegateWithMaxCrossAxisExtent(),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.greenAccent)),
                child: items[index % items.length],
              );
            }),
      );

  /// 该子类实现了一个横轴子元素为固定最大长度的layout算法
  /// 运用：[GridView.extent(maxCrossAxisExtent: maxCrossAxisExtent)]
  SliverGridDelegateWithMaxCrossAxisExtent
      sliverGridDelegateWithMaxCrossAxisExtent() {
    return const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 120,
        //maxCrossAxisExtent为子元素在横轴上的最大长度，之所以是“最大”长度，是因为横轴方向每个子元素的长度仍然是等分的
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 2);
  }

  ///该子类实现了一个横轴为固定数量子元素的layout算法
  /// 运用：[GridView.count(crossAxisCount: crossAxisCount)]
  ///可以发现，子元素的大小是通过crossAxisCount和childAspectRatio两个参数共同决定的。注意，这里的子元素指的是子组件的最大显示空间，注意确保子组件的实际大小不要超出子元素的空间。
  SliverGridDelegateWithFixedCrossAxisCount
      sliverGridDelegateWithFixedCrossAxisCount() {
    return const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      // 横轴子元素的数量。此属性值确定后子元素在横轴的长度就确定了，即ViewPort横轴长度除以crossAxisCount的商
      mainAxisSpacing: 10,
      // 主轴间距，GridView默认是垂直布局，所以是竖直方向的间距
      crossAxisSpacing: 10, // 纵轴方向，同理，这里是水平方向的
      childAspectRatio:
          1, //子元素在横轴长度和主轴长度的比例。由于crossAxisCount指定后，子元素横轴长度就确定了，然后通过此参数值就可以确定子元素在主轴的长度。
    );
  }
}
