import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:part_practise/utils/ui.dart';

/// 通过组合的方式自定义新的组件
class CustomWidgetRoutePage extends SimplePageRoute {
  CustomWidgetRoutePage({super.key}) : super('自定义组件');

  @override
  Widget pageBody(BuildContext context) => Column(
        children: [
          /// 自带的按钮还真没有渐变的属性，需要借助其他组件才能实现，比如Container里面的decoration、DecoratedBox，
          /// 但是点击需要借助其他组件InkWell或者GestureDetector
          InkWell(
            splashColor: Colors.red,
            highlightColor: Colors.transparent,
            onTap: () {
              Fluttertoast.showToast(msg: 'click');
            },
            child: Container(
              decoration: BoxDecoration(
                  gradient:
                      const LinearGradient(colors: [Colors.yellow, Colors.red]),
                  borderRadius: BorderRadius.circular(10)),
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Text('模拟渐变按钮'),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Fluttertoast.showToast(msg: 'click');
            },
            child: DecoratedBox(
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [Colors.yellow, Colors.red]),
                    borderRadius: BorderRadius.circular(10)),
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text('模拟渐变按钮DecoratedBox'),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {
                Fluttertoast.showToast(msg: 'click');
              },
              child: Container(
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [Colors.yellow, Colors.red]),
                    borderRadius: BorderRadius.circular(10)),
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text('模拟渐变按钮'),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
                onPressed: () {
                  Fluttertoast.showToast(msg: 'click');
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red)),
                child: const Text('Button组件没有渐变属性')),
          ),
          GradientButton(
            colors: const [Colors.yellow, Colors.red],
            onPressed: () {
              Fluttertoast.showToast(msg: 'click');
            },
            child: const Text('渐变按钮'),
          )
        ],
      );
}

/// 采用组合的方式实现
class GradientButton extends StatelessWidget {
  const GradientButton({
    Key? key,
    this.colors,
    this.width,
    this.height,
    this.onPressed,
    this.borderRadius,
    required this.child,
  }) : super(key: key);

  // 渐变色数组
  final List<Color>? colors;

  // 按钮宽高
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  //点击回调
  final GestureTapCallback? onPressed;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    //确保colors数组不空
    List<Color> colorGradient =
        colors ?? [theme.primaryColor, theme.primaryColorDark];

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: colorGradient),
        borderRadius: borderRadius,
        //border: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          splashColor: colorGradient.last,
          highlightColor: Colors.transparent,
          borderRadius: borderRadius,
          onTap: onPressed,
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(height: height, width: width),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultTextStyle(
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
