// import 'string_apis.dart';
/// 扩展方法，这个写法有点不能接受
extension XXX on String {
  int parseInt() {
    return int.parse(this);
  }
}

void main(List<String> args) {
  print('42'.padLeft(5)); // Use a String method.
  print('42'.parseInt()); // Use an extension method.
}
