import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:part_practise/utils/ui.dart';

/// 这个在前面已经在使用了，可以自动折行，避免超出屏幕（或者说超出父控件的大小）
class StackLayoutRoutePage extends SimplePageRoute {
  StackLayoutRoutePage() : super('Stack');

  @override
  Widget pageBody(BuildContext context) => SizedBox(
        width: double.infinity,
        height: double.infinity,
        // 这里用SizedBox是因为限制下大小，Stack本身没有确定大小，根据父组件来的
        child: Stack(
          alignment: AlignmentDirectional.center,
          textDirection: TextDirection.ltr,
          fit: StackFit.loose,
          children: const <Widget>[
            Positioned(
                left: 30,
                top: 30,
                child: Chip(
                  avatar: CircleAvatar(
                      backgroundColor: Colors.blue, child: Text('A')),
                  label: Text('A'),
                )),
            Positioned(
                left: 50,
                top: 50,
                child: Chip(
                  avatar: CircleAvatar(
                      backgroundColor: Colors.blue, child: Text('M')),
                  label: Text('B'),
                )),
            Positioned(
                left: 70,
                top: 70,
                child: Chip(
                  avatar: CircleAvatar(
                      backgroundColor: Colors.blue, child: Text('H')),
                  label: Text('C'),
                )),
            // 这个没有使用Positioned，既没有定位，使用alignment来指定
            Chip(
              avatar:
                  CircleAvatar(backgroundColor: Colors.blue, child: Text('J')),
              label: Text('D'),
            ),
          ],
        ),
      );
}
