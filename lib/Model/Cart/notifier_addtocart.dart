import 'package:flutter/material.dart';

class CountNotifier extends ChangeNotifier {
  CountNotifier(this.counter);
  int counter = 0;
  void increment() {
    counter++;
    notifyListeners();
  }
}
