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
  Widget pageBody(BuildContext context) => Column(
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
          ),
          _ProgressAnimationWidget()
        ],
      );
}
/// 展示一个耗时3秒的从灰色到蓝色的进度条，这里借助StatefulWidget来刷新进度条，并更新进度
/// 具体动画是怎么操作的，先忽略
class _ProgressAnimationWidget extends StatefulWidget {
  @override
  _ProgressAnimationWidgetState createState() => _ProgressAnimationWidgetState();
}

class _ProgressAnimationWidgetState extends State<_ProgressAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    //动画执行时间3秒
    _animationController = AnimationController(
      vsync: this, //注意State类需要混入SingleTickerProviderStateMixin（提供动画帧计时/触发器）
      duration: const Duration(seconds: 3),
    );
    _animationController.forward();
    _animationController.addListener(() => setState(() => {}));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: LinearProgressIndicator(
        backgroundColor: Colors.grey[200],
        valueColor: ColorTween(begin: Colors.grey, end: Colors.blue)
            .animate(_animationController), // 从灰色变成蓝色
        value: _animationController.value,
      ),
    );
  }
}