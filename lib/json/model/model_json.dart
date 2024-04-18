class Product {
  String name;
  String image;
  double price;
  int quantity;
  String category;

  Product(
      {required this.name,
      required this.image,
      required this.price,
      required this.quantity,
      required this.category});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      price: (json['price'] ?? 0.0)
          .toDouble(), 
      quantity: json['quantity'] ?? 0,
      category: json['category'] ?? '',
    );
  }
}

class Category {
  String title;
  String imagePath;
  List<Product>? items;

  Category({required this.title, required this.imagePath, this.items});

  factory Category.fromJson(Map<String, dynamic> json) {
    var list = json['items'] as List;
    List<Product> itemList = list.map((i) => Product.fromJson(i)).toList();

    return Category(
      title: json['title'],
      imagePath: json['imagePath'],
      items: itemList,
    );
  }
}

class GroceryData {
  List<Category> categories;

  GroceryData({required this.categories});

  factory GroceryData.fromJson(Map<String, dynamic> json) {
    var list = json['categories'] as List;
    List<Category> categoryList =
        list.map((i) => Category.fromJson(i)).toList();

    return GroceryData(categories: categoryList);
  }
}
