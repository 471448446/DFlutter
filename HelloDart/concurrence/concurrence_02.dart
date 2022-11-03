/// 运行后输出：
/// run
/// run done
/// Unhandled exception:
/// ....
/// Exited
/// 同理，虽然在main函数中，没有得到future的最终结果，因为它是一个延时操作。但是最后程序还是发生了异常。
/// 因为main函数对应的程序，要等到所有的future结束，才会退出
void main(List<String> args) {
  print('run');
  _fetchUserOrder();
  print('run done');
}

Future<void> _fetchUserOrder() {
// Imagine that this function is fetching user info but encounters a bug
  return Future.delayed(const Duration(seconds: 2),
      () => throw Exception('Logout failed: user ID is invalid'));
}
