import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Scaffold2RoutePage extends StatelessWidget {
  const Scaffold2RoutePage({super.key});

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(title: const Text('底部镂空'),),
        floatingActionButton: FloatingActionButton(onPressed: () {

        }, child: const Icon(Icons.add),),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,// 这才是关键一句
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.home)),
              const SizedBox(),
              IconButton(onPressed: () {}, icon: const Icon(Icons.business)),
            ],
          ),
        ),
      );
}
