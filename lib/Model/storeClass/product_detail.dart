import 'package:flutter/material.dart';

class ProductListView extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final Widget Function(Map<String, dynamic>, bool, int) itemBuilder;

  const ProductListView(
      {super.key, required this.items, required this.itemBuilder});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: items.length,
      itemBuilder: (context, i) {
        final item = items[i];
        bool added = item['added'] ?? false;
        return itemBuilder(item, added, i);
      },
    );
  }
}
