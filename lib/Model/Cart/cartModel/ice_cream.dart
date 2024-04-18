import 'package:flutter/material.dart';

class IceCreamProductModel {
  String name;
  double price;
  String image;
  int quantity;
  ValueNotifier<int> count;

  IceCreamProductModel({
    required this.name,
    required this.price,
    required this.image,
    required this.quantity,
  }) : count = ValueNotifier<int>(0);
}
