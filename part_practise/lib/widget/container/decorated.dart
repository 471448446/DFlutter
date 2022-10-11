import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:part_practise/utils/ui.dart';

/// 修饰
class DecoratedBoxRoutePage extends SimplePageRoute {
  DecoratedBoxRoutePage({super.key}) : super('DecoratedBox');

  @override
  Widget pageBody() => Padding(
        padding: const EdgeInsets.all(10),
        child: DecoratedBox(
          decoration: BoxDecoration(
              gradient:
                  const LinearGradient(colors: [Colors.blue, Colors.yellow]),
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black54, offset: Offset(2, 2), blurRadius: 5),
              ]),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 18.0),
            child: Text(
              "Login",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
}
