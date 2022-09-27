/// 子类需要初始化父类的构造函数，如果父类没有默认构造函数，需要显示的指定
class Persion {
  String? name;
  Persion.fromJson(String json) {
    print("in Person");
  }
}

class Employee extends Persion {
  // Person does not have a default constructor;
  // you must call super.fromJson().
  /// super.data 这里申明也需要这样一个参数，类型跟父类的一样
  Employee.fromJson(super.json) : super.fromJson() {
    print('in Employee');
  }
}

/// 父类参数，构造
class Vector2D {
  int x;
  int y;
  Vector2D(this.x, this.y);
}

class Vector3D extends Vector2D {
  int z;
  // 申明了构造函数，有三个参数，其中，前面两个用super的字段,会自动对应父类的构造函数，并初始化。
  // Forward the x and y parameters to the default super constructor like:
  // Vector3d(final double x, final double y, this.z) : super(x, y);
  Vector3D(super.x, super.y, this.z);
}

void main() {
  var employee = Employee.fromJson("假设这里是一段json字符串");
  print(employee);
  // Prints:
  // in Person
  // in Employee
  // Instance of 'Employee'
}
