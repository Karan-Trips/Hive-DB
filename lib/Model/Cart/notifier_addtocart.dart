import 'package:flutter/material.dart';

class CartNotifier extends ValueNotifier<int> {
  CartNotifier(super.value);

  void updateCartItems(cartItems) {
    value = cartItems.length;
  }
}

