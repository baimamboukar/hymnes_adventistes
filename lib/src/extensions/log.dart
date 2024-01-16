import 'dart:developer' as dev;

extension Log on Object {
  void get log => dev.log(toString());
}
