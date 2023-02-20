import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:part_practise/utils/ui.dart';

/// 1. Future.await() 等待多个任务执行完成后，返回每个任务的结果，并放在一个集合里面。
/// 需要注意的是参数eagerErr参数，如果设置为true，当某个任务抛异常后，Future.await()会立马返回结果数据为null，但是其他的任务会继续执行
/// 2.Stream.futures() 也是等待任务执行完成后，返回结果。结果是Stream类型
/// 3.FutureGroup()
class FutureCombine extends SimplePageRoute {
  FutureCombine({super.key}) : super("Future 合并多个任务");

  @override
  Widget pageBody(BuildContext context) => Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                combineAwait();
              },
              child: Text("Future.wait处理多个任务",
                  style: Theme.of(context).textTheme.titleMedium),
            ),
            ElevatedButton(
              onPressed: () {
                combineAwaitErr();
              },
              child: Text("Future.wait处理多个任务异常",
                  style: Theme.of(context).textTheme.titleMedium),
            ),
            ElevatedButton(
              onPressed: () {
                combineAwaitErrEager();
              },
              child: Text("Future.wait处理多个任务异常,快速返回异常",
                  style: Theme.of(context).textTheme.titleMedium),
            ),
            ElevatedButton(
              onPressed: () {
                combineStream();
              },
              child: Text("Stream.futures处理多个任务异常",
                  style: Theme.of(context).textTheme.titleMedium),
            ),
          ],
        ),
      );

  /*
  I/flutter (18311): Interceptor-->: task 1 run done!
  I/flutter (18311): Interceptor-->: task 2 run done!
  I/flutter (18311): Interceptor-->: task 3 run done!
  I/flutter (18311): Interceptor-->: after:3 seconds,[1, 2, 3]
   */

  /// 所有任务都完成后，Future.wait返回的结果是[1,2,3]
  combineAwait() async {
    DateTime start = DateTime.now();
    var list = await Future.wait([task(1), task(2), task(3)]);
    DateTime end = DateTime.now();
    print("after:${end.difference(start).inSeconds} seconds,$list");
  }

  /*
  I/flutter (18311): Interceptor-->: task 1 run done!
  I/flutter (18311): Interceptor-->: task 2 run done!
  I/flutter (18311): Interceptor-->: task 3 run done!
  I/flutter (18311): Interceptor-->: catch Future.wait() err: 2测试异常
  I/flutter (18311): Interceptor-->: after:3 seconds,null
   */

  /// 其中一个任务跑异常，所有任务都完成后，Future.wait返回的结果是null。
  combineAwaitErr() async {
    DateTime start = DateTime.now();
    var list = await Future.wait([task(1), task(2, pledgeErr: true), task(3)])
        .catchError((e) {
      print("catch Future.wait() err: $e");
    });
    DateTime end = DateTime.now();
    print("after:${end.difference(start).inSeconds} seconds,$list");
  }

  /*
  I/flutter (18311): Interceptor-->: task 1 run done!
  I/flutter (18311): Interceptor-->: task 2 run done!
  I/flutter (18311): Interceptor-->: catch Future.wait() err: 2测试异常
  I/flutter (18311): Interceptor-->: after:2 seconds,null
  I/flutter (18311): Interceptor-->: task 3 run done!
   */

  /// eager设置为ture，虽然某个任务发生错误后，立即返回的结果，但是其他的任务并没有终止
  combineAwaitErrEager() async {
    DateTime start = DateTime.now();
    var list = await Future.wait([task(1), task(2, pledgeErr: true), task(3)],
            eagerError: true)
        .catchError((e) {
      print("catch Future.wait() err: $e");
    });
    DateTime end = DateTime.now();
    print("after:${end.difference(start).inSeconds} seconds,$list");
  }

  /*
  I/flutter (18311): Interceptor-->: task 1 run done!
  I/flutter (18311): Interceptor-->: task 2 run done!
  I/flutter (18311): Interceptor-->: task 3 run done!
  I/flutter (18311): Interceptor-->: after:3 seconds,1,2,3
   */

  /// 等待所有任务都处理完成后，返回结果
  combineStream() async {
    DateTime start = DateTime.now();
    var stream =
        await Stream.fromFutures([task(1), task(2), task(3)]).join(",");
    DateTime end = DateTime.now();
    print("after:${end.difference(start).inSeconds} seconds,$stream");
  }

  Future<int> task(int value, {bool pledgeErr = false}) async {
    print("task $value run run");
    await Future.delayed(Duration(seconds: value));
    print("task $value run done!");
    if (pledgeErr) {
      return Future.error("$value测试异常");
    }
    return value;
  }
}
