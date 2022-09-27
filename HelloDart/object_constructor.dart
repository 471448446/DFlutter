/// 构造函数

class Point {
  ///得！非空变量必须赋值，难道它不能自己赋默认值吗？
  int x = 0;
  int y = 0;
  // z 可空，默认值为null
  int? z;

  /// 1. 一般写法的构造函数
  /// 构造函数，因为在dart中可以省略返回类型，所以，构造函数可以看作是方法名跟类型一样得函数。
  Point(int x, int y) {
    ///当且仅当命名冲突时使用 this 关键字才有意义，否则 Dart 会忽略 this 关键字。
    this.x = x;
    this.y = y;
  }

  /// 2. 命名式构造函数，又是语法糖语法糖
  Point.normal()
      : x = 0,
        y = 0;
}

class PointDefaultVariable {
  int x;

  /// 3. 终值初始化，语法糖
  /// 对于大多数编程语言来说在构造函数中为实例变量赋值的过程都是类似的，而 Dart 则提供了一种特殊的语法糖来简化该步骤。
  /// 构造中初始化的参数可以用于初始化非空或 final 修饰的变量，它们都必须被初始化或提供一个默认值。
  PointDefaultVariable(this.x);
}

void main(List<String> args) {
  var p1 = Point(2, 2);
  //获取对象的类型
  print(" type is: ${p1.runtimeType}");
  var p2 = PointDefaultVariable(2);
  print(" p2 type is: ${p2.runtimeType},x = ${p2.x}");
}
