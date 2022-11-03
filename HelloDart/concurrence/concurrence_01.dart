/// 错误的使用方式，
/// ----run
/// Your order is: Instance of 'Future<String>'
/// ----run done
/// future run--
/// Exited
///  虽然future的结果并没有获取到，但是future最后却执行了，也就是说所有的future运行完成后，程序才会结束
void main(List<String> args) {
  print('----run');
  print(_createOrderMessage());
  print('----run done');
}

String _createOrderMessage() {
  // 这里没有去等待Future返回的结果，所以是错误的
  // _fetchUserOrder返回的是一个Future的引用，将来某个时刻会返回结果，这里直接拿到这个引用就结束了
  var order = _fetchUserOrder();
  return 'Your order is: $order';
}

Future<String> _fetchUserOrder() =>
    // Imagine that this function is more complex and slow.
    Future.delayed(
      const Duration(seconds: 2),
      () {
        print('future run--');
        return 'Large Latte';
      },
    );
