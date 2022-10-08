import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:part_practise/utils/ui.dart';

/// 输入框
/// https://book.flutterchina.club/chapter3/input_and_form.htm
/// 如何获取文本
/// 1. 通过TextFiled的onChange回调
/// 2. 或者通过TextEditingController
/// 监听文本变化
/// 1. 通过TextFiled的onChange回调
/// 2. 或者通过TextEditingController.addListener
/// 焦点控制
/// 焦点可以通过FocusNode和FocusScopeNode来控制，默认情况下，焦点由FocusScope来管理，它代表焦点控制范围，
/// 可以在这个范围内可以通过FocusScopeNode在输入框之间移动焦点、设置默认焦点等
class InputRoutePage extends SimplePageRoute {
  InputRoutePage() : super('输入框');

  @override
  Widget pageBody() {
    final loginNameController = TextEditingController();
    final loginPwdController = TextEditingController();
    // 监听文本变化
    loginPwdController.addListener(() {});

    final selectTextController = TextEditingController();
    selectTextController.text = 'HelloWorld!!';
    selectTextController.selection = TextSelection(
        baseOffset: 2, extentOffset: selectTextController.text.length);
    return Column(
      children: [
        TextField(
          autofocus: true,
          decoration: const InputDecoration(
              labelText: "用户名",
              hintText: "请输入用户名",
              hintMaxLines: 1,
              hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
              prefixIcon: Icon(Icons.person)),
          onChanged: (String text) {
            Fluttertoast.showToast(
                msg: text,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER);
          },
          controller: loginNameController,
        ),
        TextField(
          decoration: const InputDecoration(
              labelText: "密码",
              hintText: "请输入用密码",
              hintMaxLines: 1,
              hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
              prefixIcon: Icon(Icons.lock)),
          // 输入的文字加密
          obscureText: true,
          controller: loginPwdController,
        ),
        ElevatedButton(
            onPressed: () {
              Fluttertoast.showToast(
                  msg:
                      "用户名：${loginNameController.text},密码： ${loginPwdController.text}");
              // 显示不出来？
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      "用户名：${loginNameController.text},密码： ${loginPwdController.text}")));
            },
            child: const Text('登录')),
        TextField(
          controller: selectTextController,
        ),
      ],
    );
  }
}
