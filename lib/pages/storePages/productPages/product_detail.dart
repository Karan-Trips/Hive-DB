import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:task_27_03/pages/storePages/productPages/product_view_detail.dart';

class MilkProductsPage extends StatefulWidget {
  const MilkProductsPage({
    super.key,
    required this.title,
    required this.items,
    required this.storename,
    required this.count,
    required this.index,
  });

  final String title;
  final int count;
  final int index;
  final String storename;
  final List<dynamic> items;

  @override
  State<MilkProductsPage> createState() => _MilkProductsPageState();
}

class _MilkProductsPageState extends State<MilkProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 21,
          ),
          itemCount: widget.items.length,
          itemBuilder: (context, index) {
            final product = widget.items[index];

            return Stack(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsPage(
                          storename: widget.storename,
                          items: widget.items[index],
                          index: index,
                          listindex: widget.index,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xffFFFFFF),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Center(
                            child: SizedBox(
                              child: Image.asset(
                                product.imageurl,
                                height: 64.h,
                                width: 60.w,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 11,
                            top: 14,
                            right: 11,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\$${product.price.value}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(product.quantity.toString()),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 11),
                            child: Text(
                              product.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: widget.items[index].count,
                  builder: (context, value, child) =>
                      widget.items[index].count.value > 0
                          ? addDottedContainer('milk', index)
                          : expandedContainer('milk', index),
                ),
                //
              ],
            );
          },
        ),
      ),
    );
  }

  Positioned expandedContainer(String category, int index) {
    return Positioned(
      top: 5,
      right: 10,
      child: ValueListenableBuilder(
        valueListenable: widget.items[index].count,
        builder: (context, value, child) => InkWell(
          onTap: () {
            widget.items[index].count.value++;
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 9, right: 15),
            child: DottedBorder(
              color: Colors.green,
              strokeWidth: 1,
              dashPattern: const [6, 6, 6, 6],
              borderType: BorderType.Circle,
              radius: const Radius.circular(50),
              child: _dottedContainer(),
            ),
          ),
        ),
      ),
    );
  }

  Positioned addDottedContainer(String category, int index) {
    return Positioned(
      top: 5,
      right: 10,
      child: ValueListenableBuilder(
        valueListenable: widget.items[index].count,
        builder: (context, value, child) => InkWell(
          onTap: () {
            widget.items[index].count.value++;
            // widget.items[index].count.notifyListeners();
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1.w, color: Colors.green),
              borderRadius: BorderRadius.circular(50.r),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 9,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      widget.items[index].count.value++;
                    },
                    child: const Icon(
                      Icons.add,
                      size: 29,
                    ),
                  ),
                  Text(
                    "${widget.items[index].count.value}",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      widget.items[index].count.value--;
                      // widget.items[index].count.notifyListeners();
                    },
                    child: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _dottedContainer() {
    return Container(
      height: 26.r,
      width: 26.r,
      decoration: BoxDecoration(
          color: const Color.fromRGBO(68, 177, 44, 0.1),
          borderRadius: BorderRadius.circular(50)),
      child: const Center(
          child: Icon(
        Icons.add,
        color: Colors.green,
      )),
    );
  }
}
