import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:part_practise/utils/ui.dart';

/// 实际上AlertDialog和SimpleDialog都使用了Dialog类。由于AlertDialog和SimpleDialog中
/// 使用了IntrinsicWidth来尝试通过子组件的实际尺寸来调整自身尺寸，这就导致他们的子组件不能是
/// 延迟加载模型的组件（如ListView、GridView 、 CustomScrollView等）。
///
/// https://book.flutterchina.club/chapter7/dailog.html
class AlertDialogRoutePage extends SimplePageRoute {
  AlertDialogRoutePage({super.key}) : super('Dialog');

  @override
  Widget pageBody(BuildContext context) => Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () async {
                  //弹出对话框并等待其关闭
                  bool? delete = await popAlertDialog();
                  if (delete == null) {
                    Fluttertoast.showToast(msg: "点击取消");
                  } else {
                    Fluttertoast.showToast(msg: "点击确认");
                  }
                },
                child: const Text('Pop AlertDialog')),
            ElevatedButton(
                onPressed: () async {
                  //弹出对话框并等待其关闭
                  int? delete = await popSampleDialog();
                  Fluttertoast.showToast(msg: "选择结果：$delete");
                },
                child: const Text('Pop SimpleDialog')),
            ElevatedButton(
                onPressed: () {
                  showListDialog();
                },
                child: const Text('Pop Dialog')),
            ElevatedButton(
                onPressed: () {
                  showCustomDialog();
                },
                child: const Text('自定义弹窗')),
            /// 下面三个都是处理弹窗上面的状态变化，原则是要刷新UI。
            ElevatedButton(
                onPressed: () {
                  showDeleteConfirmDialog1();
                },
                child: const Text('弹窗状态管理-使用单独的StatefulWidget')),
            ElevatedButton(
                onPressed: () {
                  showDeleteConfirmDialog2();
                },
                child: const Text('弹窗状态管理-使用StatefulBuilder')),
            ElevatedButton(
                onPressed: () {
                  showDeleteConfirmDialog3();
                },
                child: const Text('弹窗状态管理-markNeedsBuild')),
          ],
        ),
      );

  // 弹窗一个AlertDialog
  Future<bool?> popAlertDialog() {
    return showDialog(
        context: context,
        // 点击空白处是否取消
        barrierDismissible: false,
        barrierColor: const Color(0xFFFFEBEE),
        builder: (context) {
          return AlertDialog(
            icon: const Icon(Icons.question_mark),
            iconColor: Colors.red,
            title: const Text("这是标题"),
            // 文本太长
            content: SingleChildScrollView(
              child: Text('确定要飞吗？' * 100),
            ),
            contentPadding: const EdgeInsets.all(3),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    //关闭对话框并返回true
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('确定')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('取消')),
            ],
          );
        });
  }

  Future<int?> popSampleDialog() => showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('请选择语言'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                // 返回1
                Navigator.pop(context, 1);
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: Text('中文简体'),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                // 返回2
                Navigator.pop(context, 2);
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: Text('美国英语'),
              ),
            ),
          ],
        );
      });

  Future<void> showListDialog() async {
    int? index = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        var child = Column(
          children: <Widget>[
            const ListTile(title: Text("请选择")),
            Expanded(
                child: ListView.builder(
              itemCount: 30,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text("$index"),
                  onTap: () => Navigator.of(context).pop(index),
                );
              },
            )),
          ],
        );
        //使用AlertDialog会报错
        //return AlertDialog(content: child);
        return Dialog(child: child);
      },
    );
    if (index != null) {
      Fluttertoast.showToast(msg: "点击了：$index");
    }
  }

  void showCustomDialog() {
    _CustomDialog.showCustomDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Text("您确定要删除当前文件吗?"),
          actions: <Widget>[
            TextButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text("删除"),
              onPressed: () {
                // 执行删除操作
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool?> showDeleteConfirmDialog1() {
    bool _withTree = false; //记录复选框是否选中
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("您确定要删除当前文件吗?"),
              Row(
                children: <Widget>[
                  Text("同时删除子目录？"),
                  DialogCheckbox(
                    value: _withTree, //默认不选中
                    onChanged: (bool? value) {
                      //更新选中状态
                      _withTree = !_withTree;
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text("删除"),
              onPressed: () {
                // 将选中状态返回
                Navigator.of(context).pop(_withTree);
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool?> showDeleteConfirmDialog2() {
    bool _withTree = false; //记录复选框是否选中
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("您确定要删除当前文件吗?"),
              Row(
                children: <Widget>[
                  Text("同时删除子目录？"),
                  StatefulBuilder(builder: (context, _setState) {
                    return Checkbox(
                      value: _withTree, //默认不选中
                      onChanged: (bool? value) {
                        //_setState方法实际就是该StatefulWidget的setState方法，
                        //调用后builder方法会重新被调用
                        _setState(() {
                          //更新选中状态
                          _withTree = !_withTree;
                        });
                      },
                    );
                  }),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text("删除"),
              onPressed: () {
                // 将选中状态返回
                Navigator.of(context).pop(_withTree);
              },
            ),
          ],
        );
      },
    );
  }

  //66
  Future<bool?> showDeleteConfirmDialog3() {
    bool _withTree = false; //记录复选框是否选中
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("您确定要删除当前文件吗?"),
              Row(
                children: <Widget>[
                  Text("同时删除子目录？"),
                  // 是要Builder。缩小刷新范围
                  Builder(builder: (context) {
                    return Checkbox(
                      value: _withTree, //默认不选中
                      onChanged: (bool? value) {
                        //_setState方法实际就是该StatefulWidget的setState方法，
                        //调用后builder方法会重新被调用
                        _withTree = !_withTree;
                        (context as Element).markNeedsBuild();
                      },
                    );
                  }),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text("删除"),
              onPressed: () {
                // 将选中状态返回
                Navigator.of(context).pop(_withTree);
              },
            ),
          ],
        );
      },
    );
  }
}

/// 自定义对话框，利用[showGeneralDialog]弹出
class _CustomDialog {
  static Future<T?> showCustomDialog<T>({
    required BuildContext context,
    bool barrierDismissible = true,
    required WidgetBuilder builder,
    ThemeData? theme,
  }) {
    // final ThemeData theme = Theme.of(context, shadowThemeOnly: true);
    final ThemeData theme = Theme.of(context);
    return showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        final Widget pageChild = Builder(builder: builder);
        return SafeArea(
          child: Builder(builder: (BuildContext context) {
            return theme != null
                ? Theme(data: theme, child: pageChild)
                : pageChild;
          }),
        );
      },
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black87,
      // 自定义遮罩颜色
      transitionDuration: const Duration(milliseconds: 150),
      transitionBuilder: _buildMaterialDialogTransitions,
    );
  }

  static Widget _buildMaterialDialogTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    // 使用缩放动画
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      ),
      child: child,
    );
  }
}

///----------------弹窗上的状态管理 start
// 单独封装一个内部管理选中状态的复选框组件
class DialogCheckbox extends StatefulWidget {
  DialogCheckbox({
    Key? key,
    this.value,
    required this.onChanged,
  });

  final ValueChanged<bool?> onChanged;
  final bool? value;

  @override
  _DialogCheckboxState createState() => _DialogCheckboxState();
}

class _DialogCheckboxState extends State<DialogCheckbox> {
  bool? value;

  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: (v) {
        //将选中状态通过事件的形式抛出
        widget.onChanged(v);
        setState(() {
          //更新自身选中状态
          value = v;
        });
      },
    );
  }
}

///----------------弹窗上的状态管理 end
///----------------弹窗上的状态管理 start2
///class Builder extends StatelessWidget {
class StatefulBuilder extends StatefulWidget {
  const StatefulBuilder({
    Key? key,
    required this.builder,
  })  : assert(builder != null),
        super(key: key);

  final StatefulWidgetBuilder builder;

  @override
  _StatefulBuilderState createState() => _StatefulBuilderState();
}

class _StatefulBuilderState extends State<StatefulBuilder> {
  @override
  Widget build(BuildContext context) => widget.builder(context, setState);
}

///----------------弹窗上的状态管理 end2
