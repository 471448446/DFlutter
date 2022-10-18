import 'package:flutter/material.dart';
import 'package:part_practise/utils/ui.dart';

class ContainerRoutePage extends SimplePageRoute {
  ContainerRoutePage({super.key}) : super('Container');

  @override
  Widget pageBody(BuildContext context) => Column(
        children: [
          const Text('综合应用'),
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
          const Text('下面是：margin!!!'),
          Container(
            margin: EdgeInsets.all(20.0), //容器外补白
            color: Colors.orange,
            child: Text("Hello world!"),
          ),
          const Text('下面是：padding!!!'),
          Container(
            padding: EdgeInsets.all(20.0), //容器内补白
            color: Colors.orange,
            child: Text("Hello world!"),
          )
        ],
      );
}
