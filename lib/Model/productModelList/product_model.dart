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
  final double price;
  final String details;
  final String imageurl;
  late final CountNotifier count;

  Subcategory(
      {required this.name,
      required this.price,
      required this.details,
      required this.count,
      required this.imageurl});
}

List<Subcategory> bakery = [
  Subcategory(
      count: CountNotifier(0),
      name: 'Croissants',
      price: 1.5,
      details: 'Freshly baked, Pack of 4',
      imageurl: 'assets/images/snack4.png'),
  Subcategory(
      count: CountNotifier(0),
      name: 'Bagels',
      price: 1.0,
      details: 'Plain, Pack of 6',
      imageurl: 'assets/images/milk-box.png'),
  Subcategory(
      count: CountNotifier(0),
      name: 'Whole Wheat Bread',
      price: 2.0,
      details: 'Loaf',
      imageurl: 'assets/images/milk-bottle.png'),
];
List<Subcategory> milkitems = [
  Subcategory(
      count: CountNotifier(0),
      name: 'Whole Milk',
      price: 2.0,
      details: '1 gallon',
      imageurl: 'assets/images/milk.png'),
  Subcategory(
      count: CountNotifier(0),
      name: 'Skim Milk',
      price: 2.5,
      details: '1 gallon',
      imageurl: 'assets/images/milk-box.png'),
  Subcategory(
      count: CountNotifier(0),
      name: 'Almond Milk',
      price: 3.0,
      details: '32 oz',
      imageurl: 'assets/images/milk-bottle.png'),
];
List<Subcategory> snacks = [
  Subcategory(
      count: CountNotifier(0),
      name: 'Potato Chips',
      price: 2.0,
      details: 'Salted, 100g',
      imageurl: 'assets/images/snack1.png'),
  Subcategory(
      count: CountNotifier(0),
      name: 'Trail Mix',
      price: 4.5,
      details: 'Assorted Nuts, 250g',
      imageurl: 'assets/images/snacks2.png'),
  Subcategory(
      count: CountNotifier(0),
      name: 'Granola Bars',
      price: 1.5,
      details: 'Mixed Berries, Pack of 6',
      imageurl: 'assets/images/snack3.png'),
];
List<Subcategory> dairy = [
  Subcategory(
      count: CountNotifier(0),
      name: 'Lactaid Fat Free Pure Milk',
      price: 15.0,
      details: '20 mg',
      imageurl: 'assets/images/milk-box.png'), // Subcategory(
  Subcategory(
      count: CountNotifier(0),
      name: 'Lactaid Whole Pure Milk',
      price: 35.0,
      details: '22 mg',
      imageurl: 'assets/images/milk-bottle.png'),
  Subcategory(
      count: CountNotifier(0),
      name: 'Lactaid Milk',
      price: 3.0,
      details: '',
      imageurl: 'assets/images/milk.png'),
  Subcategory(
      count: CountNotifier(0),
      name: 'Organic Eggs',
      price: 5.0,
      details: 'Dozen',
      imageurl: 'assets/images/milk-bottle.png'),
  Subcategory(
      count: CountNotifier(0),
      name: 'Greek Yogurt',
      price: 2.5,
      details: 'Plain, 200g',
      imageurl: 'assets/images/milk.png'),
];
final List<Category> categories = [
  Category(
    id: 0,
    name: 'Dairy & Eggs',
    subcategories: [dairy, snacks, milkitems],
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
