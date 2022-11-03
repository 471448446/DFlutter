Future<String> _createOrderMessage() async {
  var order = await _fetchUserOrder();
  return 'Your order is: $order';
}

Future<String> _fetchUserOrder() =>
    // Imagine that this function is
    // more complex and slow.
    Future.delayed(
      const Duration(seconds: 2),
      () => 'Large Latte',
    );
/*
执行输出：
Fetching user order...
Your order is: Large Latte
Exited
*/
Future<void> main() async {
  print('Fetching user order...');
  print(await _createOrderMessage());
}
