void main() async {
  var stream = _simpleStream(10);
  var sum = await _sum(stream);
  print(sum); // 55
}

/// 使用async* 创建stream
Stream<int> _simpleStream(int size) async* {
  for (int i = 1; i <= size; i++) {
    yield i;
  }
}

/// 使用 await for 收集stream数据
Future<int> _sum(Stream<int> stream) async {
  var sum = 0;
  await for (final value in stream) {
    sum += value;
  }
  return sum;
}
