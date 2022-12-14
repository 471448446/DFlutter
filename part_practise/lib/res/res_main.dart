import 'package:flutter/cupertino.dart';
import 'package:part_practise/utils/ui.dart';

/// https://book.flutterchina.club/chapter2/flutter_assets_mgr.html
class ResourceWidget extends StatelessWidget {
  const ResourceWidget({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const TextTitleWidget("资源"),
          Row(
            children: [
              // 这太容易写错路径
              Image.asset(
                "assets/images/icon.png",
                width: 100,
                height: 100,
              ),
              _Image(),
            ],
          )
        ],
      );
}

/// 注意，AssetImage 并非是一个widget， 它实际上是一个ImageProvider
class _Image extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const SizedBox(
        // 原来一开始这里没展示出来是，因为没有指定大小，
        width: 100,
        height: 100,
        child: DecoratedBox(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/icon.png")))),
      );
}
