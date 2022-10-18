import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:part_practise/utils/ui.dart';

/// 裁剪
class ClipRoutePage extends SimplePageRoute {
  ClipRoutePage({super.key}) : super('Clip');

  @override
  Widget pageBody(BuildContext context) {
    final image = Image.asset('assets/images/icon.png');
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text('原始图片'),
          image,
          const Text(
            '圆形裁剪：子组件为正方形时剪裁成内贴圆形；为矩形时，剪裁成内贴椭圆',
            textAlign: TextAlign.center,
          ),
          ClipOval(
            child: image,
          ),
          const Text('圆形裁剪2：将子组件剪裁为圆角矩形'),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: image,
          ),
          const Text(
              '溢出裁剪：\n第一个图片溢出部分依然会显示，所以第一个“你好世界”会和图片的另一部分重合，为了剪裁掉溢出部分，我们在第二个Row中通过ClipRect将溢出部分剪裁掉了'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                widthFactor: .5, //宽度设为原来宽度一半，另一半会溢出
                child: image,
              ),
              const Text(
                "你好世界",
                style: TextStyle(color: Colors.green),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipRect(
                //将溢出部分剪裁
                child: Align(
                  alignment: Alignment.topLeft,
                  widthFactor: .5, //宽度设为原来宽度一半
                  child: image,
                ),
              ),
              const Text("你好世界", style: TextStyle(color: Colors.green))
            ],
          ),
          const Text(
              '自定义裁剪区域\n可以看到我们的剪裁成功了，但是图片所占用的空间大小仍然是60×60（原来图片的大小，这里不是60，红色区域），这是因为组件大小是是在layout阶段确定的，而剪裁是在之后的绘制阶段进行的，所以不会影响组件的大小，这和Transform原理是相似的。'),
          DecoratedBox(
            decoration: const BoxDecoration(color: Colors.red),
            child: ClipRect(
                clipper: _CustomClipper(), //使用自定义的clipper
                child: image),
          ),
          DecoratedBox(
            decoration: const BoxDecoration(color: Colors.blue),
            child: ClipPath(
                clipper: _CustomClipper2(), //使用自定义的clipper
                child: image),
          )
        ],
      ),
    );
  }
}

class _CustomClipper extends CustomClipper<Rect> {
  ///是用于获取剪裁区域的接口，假设图片大小是60×60，我们返回剪裁区域为Rect.fromLTWH(10.0, 15.0, 40.0, 30.0)，即图片中部40×30像素的范围。
  @override
  Rect getClip(Size size) => const Rect.fromLTWH(10.0, 15.0, 40.0, 30.0);

  /// 接口决定是否重新剪裁。如果在应用中，剪裁区域始终不会发生变化时应该返回false，这样就不会触发重新剪裁，避免不必要的性能开销。
  /// 如果剪裁区域会发生变化（比如在对剪裁区域执行一个动画），那么变化后应该返回true来重新执行剪裁。
  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) => false;
}

class _CustomClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) => Path()

    /// 这个语法糖不错，类似于kotlin中的 also，apply等
    ..moveTo(0, 0)
    ..lineTo(30, 70)
    ..lineTo(70, 30)
    ..close();

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
