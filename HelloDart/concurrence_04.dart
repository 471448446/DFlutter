import 'dart:math';

/// 异常是可以被 catch住的
void main(List<String> args) async {
  await _testMethod();
}

Future<void> _testMethod() async {
  print('before  await');
  try {
    var result = await Future.delayed(Duration(seconds: 2), () {
      throw 'Test Err';
    });
    print('after  await');
  } catch (e) {
    print('run err:');
  }
}
