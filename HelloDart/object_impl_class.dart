/// 类实现另外一个类
// A person. The implicit interface contains greet().
class Person {
  // In the interface, but visible only in this library.
  // final意味着，子类不能赋值，那么只需要重新getter就行
  final String _name;

  // Not in the interface, since this is a constructor.
  Person(this._name);

  // In the interface.
  String greet(String who) => 'Hello, $who. I am $_name.';
}

// An implementation of the Person interface.
class Impostor implements Person {
  String get _name => '';

  /// 这里重写了方法，所以值不一样
  String greet(String who) => 'Hi $who. Do you know who I am?';
}

String greetBob(Person person) => person.greet('Bob');

void main() {
  print(greetBob(Person('Kathy')));
  print(greetBob(Impostor()));
}
