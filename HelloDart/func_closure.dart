/// 闭包https://dart.cn/guides/language/language-tour#lexical-closures
int sum1(List<int> array) {
  return array.reduce((value, element) => value + element);
}

/// 返回类型暂时不知道怎么写，忽略！！！得益于dart中可以省略声明函数的返回类型。
sum2(List<int> array) {
  var func = () => array.reduce((value, element) => value + element);
  return func;
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
}
