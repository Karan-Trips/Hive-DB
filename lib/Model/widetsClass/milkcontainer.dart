import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../storeClass/product_detail.dart';

class BuildContainer extends StatelessWidget {
  const BuildContainer({
    super.key,
    required this.context,
    required this.title,
    required this.items,
    required this.itemBuilder,
  });

  final BuildContext context;
  final String title;
  final List<Map<String, dynamic>> items;
  final Widget Function(Map<String, dynamic> p1, bool p2, int p3) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        14.verticalSpace,
        SizedBox(
          height: 190.h,
          child: ProductListView(items: items, itemBuilder: itemBuilder),
        ),
      ],
    );
  }
}
