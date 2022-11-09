import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:part_practise/utils/ui.dart';

class LayoutDemoRoutePage extends SimplePageRoute {
  LayoutDemoRoutePage({super.key}) : super('布局Demo');

  @override
  Widget pageBody(BuildContext context) => ListView(
        children: [
          imageSelection(),
          titleSelection(),
          buttonSelection(),
          textSelection()
        ],
      );

  _buildButtonText(
    IconData icon,
    String text,
    Color color,
  ) =>
      TextButton(
        onPressed: () {
          Fluttertoast.showToast(msg: "click $text");
        },
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          ],
        ),
      );

  SizedBox imageSelection() {
    return SizedBox(
      width: double.infinity,
      height: 240,
      child: Image.asset(
        'assets/images/icon.png',
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  Container textSelection() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: const Text(
        'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
        'Alps. Situated 1,578 meters above sea level, it is one of the '
        'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
        'half-hour walk through pastures and pine forest, leads you to the '
        'lake, which warms to 20 degrees Celsius in the summer. Activities '
        'enjoyed here include rowing, and riding the summer toboggan run.',
        softWrap: true, // 设置 softwrap 为 true，文本将在填充满列宽后在单词边界处自动换行。
        style: TextStyle(color: Colors.black, fontSize: 16),
      ),
    );
  }

  Padding titleSelection() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //设置 crossAxisAlignment 属性值为 CrossAxisAlignment.start，这会将该列放置在行的起始位置。
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: const Text(
                    'Oeschinen Lake Campground',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Kandersteg, Switzerland',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                )
              ],
            ),
          ),
          const Icon(Icons.filter_list),
          const Text('41'),
        ],
      ),
    );
  }

  Padding buttonSelection() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildButtonText(Icons.phone, "Phone", Colors.blue),
          _buildButtonText(Icons.navigation, "Route", Colors.blue),
          _buildButtonText(Icons.share, "Share", Colors.blue),
        ],
      ),
    );
  }
}
