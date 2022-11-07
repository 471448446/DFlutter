import 'dart:isolate';

void main(List<String> args) {
  print('run....');
  Isolate.spawn(_justPrint, '1.....');
  Isolate.spawn(_justPrint, '2.....');
  Isolate.spawn(_justPrint, '3.....');
  print('execution from main1');
  print('execution from main2');
  print('execution from main3');

  print('done....');
}

_justPrint(var message) {
  print("_justPrint() $message");
}
