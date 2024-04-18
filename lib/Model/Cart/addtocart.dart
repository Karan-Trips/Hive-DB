class Items {
  final String imgUrl;
  final String name;
  final int quantity;
  final String mg;
  final int price;

  Items(
      {required this.imgUrl,
      required this.name,
      required this.quantity,
      required this.mg,
      required this.price});
}

class Shop {
  final String shopName;
  final List<Items> items;

  Shop({
    required this.shopName,
    required this.items,
  });
}

List<Map<String, dynamic>> cartItems = [];
