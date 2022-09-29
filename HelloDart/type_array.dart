void main(List<String> args) {
  // 数组
  print("-------------array");
  var array = ["a", "b", "c"];
  print(array.length);
  for (var item in array) {
    print("$item");
  }
  print("-------------list");
  var list = {"a", "b", "c"};
  list.add("d");
  list.removeWhere((element) => element == "a");
  print(list.length);
  for (var item in list) {
    print(item);
  }
  var list2 = <String>{};
  Set<String> list3 = {};
  assert(list2.length == list3.length);
  Set<Function(int)> funcList = {};
  funcList.add((p0) => p0);
  funcList.add((p0) => "toString:" + p0.toString());
  for (var element in funcList) {
    print(element.call(1));
  }
}
