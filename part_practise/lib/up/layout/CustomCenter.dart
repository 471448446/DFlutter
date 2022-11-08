import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:part_practise/generated/l10n.dart';
import 'package:part_practise/utils/ui.dart';

class CustomSingleWidgetRoutePage extends SimplePageRoute {
  CustomSingleWidgetRoutePage({super.key}) : super('单个child自定义');

  @override
  Widget pageBody(BuildContext context) => CustomCenter(
        child: Text("单个child自定义 ${S.of(context).description}"),
      );
}

class CustomCenter extends SingleChildRenderObjectWidget {
  const CustomCenter({Key? key, required Widget child})
      : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _CustomCenterRenderBox();
}

class _CustomCenterRenderBox extends RenderShiftedBox {
  ///  这里外界并没有传递这个child，
  _CustomCenterRenderBox({RenderBox? child}) : super(child);

  @override
  void performLayout() {
    //1. 先对子组件进行layout，随后获取它的size
    child!.layout(
      //constraints 是 CustomCenter 的父组件传递给自己的约束信息
      constraints.loosen(), //将约束传递给子节点
      parentUsesSize: true, // 因为我们接下来要使用child的size,所以不能为false
    );
    //2.根据子组件的大小确定自身的大小
    size = constraints.constrain(Size(
      /// double.infinity 就是无限大，这个在之前用过，这里的意思是CustomCenter父节点传递给自己的约束是无限大，那么就用子节点的，否正就无限大，尽可能让自己填满父元素的空间
      constraints.maxWidth == double.infinity
          ? child!.size.width
          : double.infinity,
      constraints.maxHeight == double.infinity
          ? child!.size.height
          : double.infinity,
    ));

    // 3. 根据父节点子节点的大小，算出子节点在父节点中居中之后的偏移，然后将这个偏移保存在
    // 子节点的parentData中，在后续的绘制阶段，会用到。
    BoxParentData parentData = child!.parentData as BoxParentData;
    parentData.offset = ((size - child!.size) as Offset) / 2;
  }
}
