import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:part_practise/utils/ui.dart';

class GestureDetectorScaleRoutePage extends SimplePageRoute {
  GestureDetectorScaleRoutePage({super.key}) : super('GestureDetector缩放');

  @override
  Widget pageBody(BuildContext context) => _Page();
}

class _Page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageState();
}

class _PageState extends State<_Page> {
  double _width = 200.0; //通过修改图片宽度来达到缩放效果

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        //指定宽度，高度自适应
        child: Image.asset(
          "assets/images/icon.png",
          width: _width,
          fit: BoxFit.fill, // 需要修改默认的缩放方式，默认是剧中，所以看不出来效果
        ),
        // child: Container(
        //   width: _width,
        //   height: _width,
        //   color: Colors.blue,
        // ),
        onScaleUpdate: (ScaleUpdateDetails details) {
          setState(() {
            //缩放倍数在0.8到10倍之间
            _width = 200 * details.scale.clamp(.8, 10.0);
            print("scale width: $_width");
          });
        },
      ),
    );
  }
}
