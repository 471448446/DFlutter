///Dart 是不支持多继承的，但是它支持 mixin，简单来讲 mixin 可以 “组合” 多个类
///定义一个 Person 类，实现吃饭、说话、走路和写代码功能，同时定义一个 Dog 类，实现吃饭、和走路功能：
///有啥用？？？，不如直接写几个接口，各自实现不久完事了？？？
///这里有个隐藏的逻辑就是要服用功能，Eat和Walk类都有各自的功能eat()和walk()，这里想复用他们的功能，
///而不是再去实现一次。

class Persion {
  say() {
    print("a persion say");
  }
}

mixin Eat {
  eat() {
    print("something can eat!!!");
  }
}

mixin Walk {
  walk() {
    print("something can walk!!!");
  }
}
mixin Code {
  code() {
    print('code!!!');
  }
}

class Man extends Persion with Eat, Walk {}

class Dog with Walk, Eat {}

void main(List<String> args) {
  final man = Man();
  man.eat();
  man.walk();
  print("-----------");
  final dog = Dog();
  dog.eat();
  dog.walk();
}
