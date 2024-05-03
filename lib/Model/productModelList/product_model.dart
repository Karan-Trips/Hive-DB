import 'package:flutter/material.dart';

import '../NotifierModel/model_class.dart';

class Category {
  final int id;
  final String name;
  final List<List<dynamic>> subcategories;
  final String image;

  Category(
      {required this.id,
      required this.name,
      required this.subcategories,
      required this.image});
}

class Subcategory {
  final String name;
  final CountNotifier price;
  final int quantity;
  final String details;
  final String imageurl;
  late final ValueNotifier<int> count;

  Subcategory(
      {required this.name,
      required this.price,
      required this.details,
      // required this.count,
      required this.quantity,
      required this.imageurl})
      : count = ValueNotifier(0);
}

List<Subcategory> bakery = [
  Subcategory(
      quantity: 25,
      name: 'Croissants',
      price: CountNotifier(15),
      details: 'Freshly baked, Pack of 4',
      imageurl: 'assets/images/snack4.png'),
  Subcategory(
      name: 'Bagels',
      quantity: 25,
      price: CountNotifier(1.5),
      details: 'Plain, Pack of 6',
      imageurl: 'assets/images/milk-box.png'),
  Subcategory(
      name: 'Whole Wheat Bread',
      quantity: 25,
      price: CountNotifier(1.5),
      details: 'Loaf',
      imageurl: 'assets/images/milk-bottle.png'),
];
List<Subcategory> milkitems = [
  Subcategory(
      name: 'Whole Milk',
      quantity: 20,
      price: CountNotifier(1.5),
      details: '1 gallon',
      imageurl: 'assets/images/milk.png'),
  Subcategory(
      name: 'Skim Milk',
      quantity: 30,
      price: CountNotifier(2.7),
      details: '1 gallon',
      imageurl: 'assets/images/milk-box.png'),
  Subcategory(
      name: 'Almond Milk',
      quantity: 60,
      price: CountNotifier(3.5),
      details: '32 oz',
      imageurl: 'assets/images/milk-bottle.png'),
];
List<Subcategory> snacks = [
  Subcategory(
      name: 'Potato Chips',
      quantity: 15,
      price: CountNotifier(15),
      details: 'Salted, 100g',
      imageurl: 'assets/images/snack1.png'),
  Subcategory(
      name: 'Trail Mix',
      quantity: 20,
      price: CountNotifier(25),
      details: 'Assorted Nuts, 250g',
      imageurl: 'assets/images/snacks2.png'),
  Subcategory(
      name: 'Granola Bars',
      quantity: 23,
      price: CountNotifier(2),
      details: 'Mixed Berries, Pack of 6',
      imageurl: 'assets/images/snack3.png'),
];
List<Subcategory> dairy = [
  Subcategory(
      quantity: 15,
      name: 'Lactaid Fat Free Pure Milk',
      price: CountNotifier(2.5),
      details: '20 mg',
      imageurl: 'assets/images/milk-box.png'), // Subcategory(
  Subcategory(
      quantity: 50,
      name: 'Lactaid Whole Pure Milk',
      price: CountNotifier(2.5),
      details: '22 mg',
      imageurl: 'assets/images/milk-bottle.png'),
  Subcategory(
      quantity: 10,
      name: 'Lactaid Milk',
      price: CountNotifier(2.5),
      details: '',
      imageurl: 'assets/images/milk.png'),
  Subcategory(
      quantity: 15,
      name: 'Organic Eggs',
      price: CountNotifier(2.5),
      details: 'Dozen',
      imageurl: 'assets/images/milk-bottle.png'),
  Subcategory(
      quantity: 20,
      name: 'Greek Yogurt',
      price: CountNotifier(2.5),
      details: 'Plain, 200g',
      imageurl: 'assets/images/milk.png'),
];
final List<Category> categories = [
  Category(
    id: 0,
    name: 'Dairy & Eggs',
    subcategories: [dairy, snacks],
    image: 'assets/images/food1.png',
  ),
  Category(
    id: 1,
    name: 'Snacks',
    subcategories: [snacks],
    image: 'assets/images/burger.png',
  ),
  Category(
    id: 2,
    name: 'Milk',
    subcategories: [milkitems],
    image: 'assets/images/milk.png',
  ),
  Category(
    id: 3,
    name: 'Bakery',
    subcategories: [bakery],
    image: 'assets/images/milk-bottle.png',
  ),
];
