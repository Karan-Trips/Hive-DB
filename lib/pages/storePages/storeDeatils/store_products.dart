// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:task_27_03/Model/productModelList/product_model.dart';

import '../../../Model/dottoed_container.dart';
import '../../../Model/widetsClass/imageContainer/image_container.dart';
import '../productPages/product_detail.dart';

class StoreProductDetail extends StatefulWidget {
  const StoreProductDetail({
    super.key,
  });

  @override
  State<StoreProductDetail> createState() => _StoreProductDetailState();
}

class _StoreProductDetailState extends State<StoreProductDetail> {
  TextEditingController searchController = TextEditingController();
  String search = '';
  void searchData() {}
  int selectedIndex = 0;
  int count = 0;
  String selectedCategory = 'Dairy & Eggs';

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final int productindex = arguments['storeindex'];
    final String storename = arguments['storename'];

    return Scaffold(
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: <Widget>[
            ImageContainer(
              widget: widget,
              searchController: searchController,
              productindex: productindex,
            ),
            15.verticalSpace,
            _categoryContainer(),
            14.verticalSpace,
            Column(
              children: List.generate(
                categories[selectedIndex].subcategories.length,
                (index) => Container(
                  height: 260.h,
                  decoration: const BoxDecoration(
                    color: Color(0xffF0F6EE),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 3),
                        blurRadius: 10,
                        color: Color.fromRGBO(0, 0, 0, 0.06),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              categories[selectedIndex]
                                  .subcategories[index][0]
                                  .name,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              List<dynamic> allSubcategories = [];
                              allSubcategories.addAll(
                                categories[selectedIndex].subcategories[index],
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MilkProductsPage(
                                    storename: storename,
                                    items: allSubcategories,
                                    title: categories[selectedIndex]
                                        .subcategories[index][0]
                                        .name,
                                    count: count,
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              "More",
                              softWrap: true,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            SizedBox(
                              height: 200,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: categories[selectedIndex]
                                    .subcategories[index]
                                    .length,
                                itemBuilder: (context, i) {
                                  return _productBuilder(
                                      categories[selectedIndex]
                                          .subcategories[index][i]);
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: IconButton(
                                style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.white),
                                ),
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.arrow_forward_outlined,
                                  color: Colors.green,
                                ),
                                iconSize: 35,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _categoryContainer() {
    return Container(
      height: 170.h,
      decoration: const BoxDecoration(
        color: Color(0xffF0F6EE),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 3),
            blurRadius: 10,
            color: Color.fromRGBO(0, 0, 0, 0.06),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              left: 10,
              top: 10,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Choose your Category',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 130.h,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = category.id;
                      selectedCategory = category.name;
                    });
                  },
                  child: _categoryItem(category),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _categoryItem(Category category) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 13.h),
          margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 0),
                blurRadius: 16,
                spreadRadius: 3,
                color: selectedIndex == category.id
                    ? const Color.fromRGBO(8, 255, 0, 0.17)
                    : const Color.fromRGBO(0, 0, 0, 0.1),
              )
            ],
            border: Border.all(
              color: selectedIndex == category.id ? Colors.green : Colors.white,
              width: 2.w,
            ),
          ),
          child: Image.asset(
            category.image,
            // 'assets/images/food1.png',
            height: 65.h,
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          category.name,
          style: TextStyle(
            color: selectedIndex == category.id
                ? const Color(0xff44B12C)
                : Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _productBuilder(Subcategory item) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 190.h,
              width: 147.w,
              margin: const EdgeInsets.symmetric(horizontal: 15),
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
                          item.imageurl,
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
                      bottom: 9,
                      right: 11,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$${item.price}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("${item.quantity} mg")
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 11),
                      child: Text(
                        item.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style:
                            const TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                  )
                ],
              ),
            ),
            ValueListenableBuilder(
              valueListenable: item.count,
              builder: (context, value, child) {
                if (item.count.value > 0) {
                  return addDottedContainer(item, count);
                } else {
                  return expandedContainer(item);
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  Positioned expandedContainer(Subcategory item) {
    return Positioned(
      top: 5,
      right: 10,
      child: ValueListenableBuilder(
        valueListenable: item.count,
        builder: (context, value, child) => InkWell(
          onTap: () {
            item.count.value++;
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 9, right: 15),
            child: DottedBorder(
              color: Colors.green,
              strokeWidth: 1,
              dashPattern: const [6, 6, 6, 6],
              borderType: BorderType.Circle,
              radius: const Radius.circular(50),
              child: const DottedContainer(),
            ),
          ),
        ),
      ),
    );
  }

  Positioned addDottedContainer(Subcategory item, int count) {
    return Positioned(
      top: 5,
      right: 10,
      child: ValueListenableBuilder(
        valueListenable: item.count,
        builder: (context, value, child) => Container(
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
                    item.count.value++;
                  },
                  child: const Icon(
                    Icons.add,
                    size: 29,
                  ),
                ),
                Text(
                  "${item.count.value}",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () {
                    item.count.value--;
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
    );
  }
}
