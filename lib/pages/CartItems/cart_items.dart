import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Model/Cart/addtocart.dart';
import '../../Model/widetsClass/elevatedbutton/elevated_button_class.dart';

class CartPage extends StatefulWidget {
  const CartPage({
    super.key,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late ValueNotifier totalPrice;

  late Map<String, List<Map<String, dynamic>>> itemsByShop;
  @override
  void initState() {
    super.initState();
    itemsByShop = {};
    totalPrice = ValueNotifier(0.00);

    if (cartItems.isNotEmpty) {
      for (var item in cartItems) {
        double itemTotalPrice =
            item['maindata'].price.value * item['maindata'].count.value;
        totalPrice.value += itemTotalPrice;

        String shopName = item['shopName'];
        String itemKey = item['key'].toString();
        String categoryKey = item['categoryindex'].toString();
        List<Map<String, dynamic>> shopItemList = itemsByShop[shopName] ?? [];
        if (itemsByShop.containsKey(shopName)) {
          bool itemExists = shopItemList.any((e) =>
              e['key'].toString() == itemKey &&
              e['categoryindex'].toString() == categoryKey);
          if (!itemExists) {
            shopItemList.add(item);
          }
        } else {
          itemsByShop[shopName] = [item];
        }
      }
    }
  }

  void deleteItemFromShop(String shopName, int index) {
    List<Map<String, dynamic>>? shopItems = itemsByShop[shopName];
    if (shopItems != null && index >= 0 && index < shopItems.length) {
      shopItems.removeAt(index);

      cartItems.removeWhere((item) =>
          item['shopName'] == shopName && item['categoryindex'] == index);

      if (shopItems.isEmpty) {
        itemsByShop.remove(shopName);
      }

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xffF5F5F5),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_sharp),
        ),
        centerTitle: true,
        title: const Text(
          'View Cart',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.green,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildDeliveryDateContainer(),
            const SizedBox(height: 5),
            _buildSubTotalContainer(itemsByShop),
            _buildItemsList(itemsByShop),
            const SizedBox(height: 50),
            _buildElevatedButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildItemsList(Map<String, List<Map<String, dynamic>>>? itemsByShop) {
    if (itemsByShop == null || itemsByShop.isEmpty) {
      return const Center(
        child: Text(
          'No items in the cart',
          style: TextStyle(fontSize: 16),
        ),
      );
    }
    return Column(
      children: [
        for (String key in itemsByShop.keys)
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.h),
            padding: EdgeInsets.all(16.sp),
            decoration:
                const BoxDecoration(color: Color(0xFFFFFFFF), boxShadow: [
              BoxShadow(
                  blurRadius: 10,
                  color: Color.fromRGBO(0, 0, 0, 0.16),
                  spreadRadius: 0.3,
                  offset: Offset(0, 0))
            ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  child: Text(
                    key,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                    height: 1,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: itemsByShop[key]?.length ?? 0,
                  itemBuilder: (context, index) {
                    var reversedList = itemsByShop[key]!.reversed.toList();
                    var item = reversedList[index];
                    return _buildItemRow(item, index, key);
                  },
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildItemRow(item, index, String key) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            item['maindata'].imageurl,
            height: 80,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item['maindata'].name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      deleteItemFromShop(key, index);
                      print('deleted');
                    },
                    child: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ValueListenableBuilder(
                valueListenable: item['maindata'].count,
                builder: (context, value, child) => Text(
                  '\$${(item['maindata'].price.value * item['maindata'].count.value).toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              ValueListenableBuilder(
                valueListenable: item['maindata'].count,
                builder: (context, value, child) => Text(
                  '${item['maindata'].quantity * item['maindata'].count.value} mg',
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ValueListenableBuilder(
                    valueListenable: totalPrice,
                    builder: (context, value, child) => InkWell(
                      onTap: () {
                        if (item['maindata'].count.value > 0) {
                          item['maindata'].count.value--;

                          totalPrice.value -= item['maindata'].price.value;
                          print(totalPrice.value);
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 23, bottom: 17),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.green,
                        ),
                        child: const Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    margin: const EdgeInsets.only(right: 23, bottom: 17),
                    child: ValueListenableBuilder(
                      valueListenable: item['maindata'].count,
                      builder: (context, value, child) => Text(
                        item['maindata'].count.value.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ValueListenableBuilder(
                    valueListenable: totalPrice,
                    builder: (context, value, child) => InkWell(
                      onTap: () {
                        item['maindata'].count.value++;

                        totalPrice.value += item['maindata'].price.value;
                        print(totalPrice);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 23, bottom: 17),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.green,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Padding _buildElevatedButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Elevatedbutton(
        bgColors:
            totalPrice.value > 30 ? Colors.green : const Color(0xffD4D4D4),
        txt: totalPrice.value > 30
            ? 'Proceed to Checkout'
            : '\$ 30 Min.to Checkout',
        onPressed: () {
          if (totalPrice.value > 30) {
            Navigator.pushNamed(context, "/orderBillingPage",
                arguments: totalPrice);
          } else {
            debugPrint('check the amount ');
          }
        },
        padding: EdgeInsets.symmetric(horizontal: 80.w, vertical: 15.h),
      ),
    );
  }

  Container _buildSubTotalContainer(itemsByShop) {
    print(totalPrice.value);
    return Container(
      width: double.infinity,
      height: 45.h,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(0, 0, 0, 0.06),
        boxShadow: [
          BoxShadow(
            color: Color(0xffF0F6EE),
            offset: Offset(0, 3),
            blurRadius: 10,
            blurStyle: BlurStyle.inner,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 10),
        child: ValueListenableBuilder(
          valueListenable: totalPrice,
          builder: (context, value, child) => Text(
            "Sub Total (${itemsByShop.length} items) : \$${totalPrice.value.toStringAsFixed(2)}",
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Container _buildDeliveryDateContainer() {
    return Container(
      width: double.infinity,
      height: 45.h,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(0, 0, 0, 0.06),
        boxShadow: [
          BoxShadow(
            color: Color(0xffF0F6EE),
            offset: Offset(0, 3),
            blurRadius: 10,
            blurStyle: BlurStyle.inner,
          ),
        ],
      ),
      child: const Center(
        child: Text(
          "Next delivery on Wed, 14 Nov 2020",
          style: TextStyle(
            color: Color(0xff44B12C),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
