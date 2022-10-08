import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 因为布局中又row组件，会将宽占满，所以所有的Colum中的widget都剧中展示了
class ImageRoutePage extends StatelessWidget {
  const ImageRoutePage({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
      title: "Image Demo",
      home: Scaffold(
          appBar: AppBar(title: const Text("Image Demo")),
          body: SingleChildScrollView(
            child: Column(children: [
              const Text("---本地---"),
              const Image(
                image: AssetImage("assets/images/icon.png"),
                width: 50,
              ),
              Image.asset(
                "assets/images/icon.png",
                width: 60,
                height: 60,
              ),
              const Text("---网络---"),
              const Image(
                image: NetworkImage(
                    "https://dss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/topnav/newwenku-d8c9b7b0fb.png"),
                width: 70,
              ),
              Image.network(
                "https://dss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/topnav/newfanyi-da0cea8f7e.png",
                width: 70,
                height: 70,
              ),
              const Text("---缩放模式---"),
              //图片都添加了一个边框，方便观看大小
              //会拉伸填充满显示空间，图片本身长宽比会发生变化，图片会变形。
              Row(
                children: [
                  const Text(" BoxFit.fill"),
                  Container(
                    decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: Image.asset(
                      "assets/images/icon.png",
                      width: 50,
                      height: 100,
                      fit: BoxFit.fill,
                    ),
                  )
                ],
              ),
              //这是图片的默认适应规则，图片会在保证图片本身长宽比不变的情况下缩放以适应当前显示空间，图片不会变形。
              Row(
                children: [
                  const Text(" BoxFit.contain"),
                  Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: Image.asset(
                      "assets/images/icon.png",
                      width: 50,
                      height: 100,
                      fit: BoxFit.contain,
                    ),
                  )
                ],
              ),
              //会按图片的长宽比放大后居中填满显示空间，图片不会变形，超出显示空间部分会被剪裁。
              Row(
                children: [
                  const Text(" BoxFit.cover"),
                  Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: Image.asset(
                      "assets/images/icon.png",
                      width: 50,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
              //图片的宽度会缩放到显示空间的宽度，高度会按比例缩放，然后居中显示，图片不会变形，超出显示空间部分会被剪裁。
              Row(
                children: [
                  const Text(" BoxFit.fitWidth"),
                  Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: Image.asset(
                      "assets/images/icon.png",
                      width: 50,
                      height: 100,
                      fit: BoxFit.fitWidth,
                    ),
                  )
                ],
              ),
              //图片的高度会缩放到显示空间的高度，宽度会按比例缩放，然后居中显示，图片不会变形，超出显示空间部分会被剪裁。
              Row(
                children: [
                  const Text(" BoxFit.fitHeight"),
                  Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: Image.asset(
                      "assets/images/icon.png",
                      width: 50,
                      height: 100,
                      fit: BoxFit.fitHeight,
                    ),
                  )
                ],
              ),
              // 如果需要缩放时跟contain类似，其他情况就跟none类似
              Row(
                children: [
                  const Text(" BoxFit.scaleDown"),
                  Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: Image.asset(
                      "assets/images/icon.png",
                      width: 50,
                      height: 100,
                      fit: BoxFit.scaleDown,
                    ),
                  )
                ],
              ),
              //图片没有适应策略，会在显示空间内显示图片，如果图片比显示空间大，则显示空间只会显示图片中间部分。
              Row(
                children: [
                  const Text(" BoxFit.scaleDown"),
                  Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: Image.asset(
                      "assets/images/icon.png",
                      width: 50,
                      height: 100,
                      fit: BoxFit.none,
                    ),
                  )
                ],
              ),
              // 混色
              const Text("---混色---"),
              //在图片绘制时可以对每一个像素进行颜色混合处理，color指定混合色，而colorBlendMode指定混合模式
              Image.asset(
                "assets/images/icon.png",
                color: Colors.blue,
                colorBlendMode: BlendMode.difference,
              ),
              const Text("---重复---"),
              //当图片本身大小小于显示空间时，指定图片的重复规则。
              Image.asset(
                "assets/images/icon.png",
                width: 100,
                height: 150,
                repeat: ImageRepeat.repeatY,
              ),
            ]),
          )));
}
