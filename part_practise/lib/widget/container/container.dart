import 'package:flutter/material.dart';
import 'package:part_practise/utils/ui.dart';

class ContainerRoutePage extends SimplePageRoute {
  ContainerRoutePage() : super('Container');

  @override
  Widget pageBody() => Column(
        children: [
          Container(
            width: 100,
            height: 100,
            margin: const EdgeInsets.all(50),
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [Colors.red, Colors.amber])),
            transform: Matrix4.rotationZ(0.2),
            //绕Z轴旋转
            alignment: Alignment.center,
            child: const Text(
              '5.2',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20.0), //容器外补白
            color: Colors.orange,
            child: Text("Hello world!"),
          ),
          Container(
            padding: EdgeInsets.all(20.0), //容器内补白
            color: Colors.orange,
            child: Text("Hello world!"),
          )
        ],
      );
}
