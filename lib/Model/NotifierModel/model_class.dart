import 'package:flutter/material.dart';

class CountNotifier extends ValueNotifier<double> {
  CountNotifier(super.value);

  void increment() {
    value++;
    notifyListeners();
  }

  void decrement() {
    value--;
    notifyListeners();
  }
}
