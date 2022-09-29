/// 闭包https://dart.cn/guides/language/language-tour#lexical-closures
int sum1(List<int> array) {
  return array.reduce((value, element) => value + element);
}

/// 返回类型暂时不知道怎么写，忽略！！！得益于dart中可以省略声明函数的返回类型。
Function() sum2(List<int> array) {
  var func = () => array.reduce((value, element) => value + element);
  return func;
}

/// testSum()创建了三个函数变量存放在列表中，当循环走完了，i变成了4，
/// 所以猜测这里每个函数在调用的时候值会变成4*4=18
/// 但是结果却不是这样
Set<Function()> testSum() {
  Set<Function()> tmp = {};
  for (var i = 1; i < 4; i++) {
    tmp.add(() => i * i);
  }
  return tmp;
}

void main(List<String> args) {
  var array = [1, 2, 3, 4, 5];
  // 1. 调用的时候就获取结果
  var result = sum1(array);
  print("result: $result");
  // 2. 直接调用sum2是返回的一个函数
  var result2 = sum2(array);
  print("result: $result2");
  // 在某个时刻，调用获取结果
  print("invoke:${result2()}");
  print('----------');

  /// 闭包引用了会发现变化的变量，但是这里并没有任何影响
  final testList = testSum();
  for (var item in testList) {
    print(item.call());
  }
}
