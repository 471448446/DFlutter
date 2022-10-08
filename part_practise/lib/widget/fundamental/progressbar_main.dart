import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:part_practise/utils/ui.dart';

/// 我们可以发现LinearProgressIndicator和CircularProgressIndicator，并没有提供设置圆形进度条尺寸的参数；
/// 如果我们希望LinearProgressIndicator的线细一些，或者希望CircularProgressIndicator的圆大一些该怎么做？
/// 其实LinearProgressIndicator和CircularProgressIndicator都是取父容器的尺寸作为绘制的边界的。知道了这点，
/// 我们便可以通过尺寸限制类Widget，如ConstrainedBox、SizedBox （我们将在后面容器类组件一章中介绍）来指定尺寸
///
/// 可以通过valueColor对进度条颜色做动画
class ProgressBarRoutePage extends SimplePageRoute {
  ProgressBarRoutePage({super.key}) : super('Progress Bar');

  @override
  Widget pageBody() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          LinearProgressIndicator(
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation(Colors.blue),
          ),
          //进度条显示50%
          LinearProgressIndicator(
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation(Colors.blue),
            value: .5,
          ),
          CircularProgressIndicator(
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation(Colors.blue),
            strokeWidth: 10,
          ),
          // 修改大小
          // SizedBox(
          //   width: 100,
          //   height: 100,
          //   child: CircularProgressIndicator(
          //     backgroundColor: Colors.grey[200],
          //     valueColor: const AlwaysStoppedAnimation(Colors.blue),
          //     strokeWidth: 10,
          //   ),
          // )
          // 线性进度条高度指定为3
          /// 通过组合widget来实现功能，比如在checkBox中也有类似，checkbox本身不会管理选中的状态，需要借助StatefullWidget来实现。更加灵活？？
          SizedBox(
            height: 3,
            child: LinearProgressIndicator(
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation(Colors.blue),
              value: .5,
            ),
          ),
          // 圆形进度条直径指定为100
          SizedBox(
            height: 100,
            width: 100,
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation(Colors.blue),
              // value: .7,
            ),
          )
        ],
      );
}
