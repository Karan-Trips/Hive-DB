import 'package:flutter/material.dart';

class MilkProductModel {
  String name;
  String image;
  final ValueNotifier<int> count;
  double price;
  int quantity;
  String category;
  MilkProductModel({
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
    required this.category, 
  }) : count = ValueNotifier<int>(0);
}
