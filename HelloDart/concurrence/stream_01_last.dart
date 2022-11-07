void main() async {
  // 命中条件后会停止订阅stream
  print('----------start');
  var stream = _simpleStream(10);
  var last = await stream.lastWhere((element) => element > 0);
  print(last); // 55
  print('----------start2');
  var stream2 = _simpleStream(10);
  var first = await stream2.firstWhere((element) => element > 0);
  print(first); // 55
}

/// 使用async* 创建stream
Stream<int> _simpleStream(int size) async* {
  for (int i = 1; i <= size; i++) {
    yield i;
    print('send...$i');
  }
}
