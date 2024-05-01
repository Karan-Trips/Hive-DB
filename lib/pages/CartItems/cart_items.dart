import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_27_03/Model/Cart/addtocart.dart';
import 'package:task_27_03/Model/widetsClass/elevatedbutton/elevated_button_class.dart';

class CartPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final String storeName;

  const CartPage({super.key, required this.cartItems, required this.storeName});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double calculateTotalPrice() {
    double totalPrice = 0.0;
    for (var item in widget.cartItems) {
      totalPrice += item['price'];
    }
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<Map<String, dynamic>>> itemsByShop = {};
    for (var item in widget.cartItems) {
      String shopName = item['shopName'];
      if (itemsByShop.containsKey(shopName)) {
        itemsByShop[shopName]!.add(item);
      } else {
        itemsByShop[shopName] = [item];
      }
    }

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
            _buildSubTotalContainer(),
            _buildItemsList(itemsByShop),
            const SizedBox(height: 50),
            _buildElevatedButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildItemsList(Map<String, List<Map<String, dynamic>>> itemsByShop) {
    return Column(
      children: [
        for (String shopName in itemsByShop.keys)
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
                    shopName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                ListView.separated(
                  separatorBuilder: (context, index) => const Divider(),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: itemsByShop[shopName]!.length,
                  itemBuilder: (context, index) {
                    var item = itemsByShop[shopName]![index];
                    return _buildItemRow(item);
                  },
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildItemRow(Map<String, dynamic> item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            item['imgUrl'],
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
                    item['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // deleteItem(shopName, index);
                    },
                    child: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '\$${item['price'].toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${item['mg']} mg',
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {},
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
                  const SizedBox(width: 8),
                  Container(
                    margin: const EdgeInsets.only(right: 23, bottom: 17),
                    child: Text(
                      item['quantity'].toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () {},
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
            calculateTotalPrice() > 30 ? Colors.green : const Color(0xffD4D4D4),
        txt: calculateTotalPrice() > 30
            ? 'Proceed to Checkout'
            : '\$ 30 Min.to Checkout',
        onPressed: () {
          if (calculateTotalPrice() > 30) {
            Navigator.pushNamed(context, "/orderBillingPage",
                arguments: calculateTotalPrice());
          } else {
            debugPrint('check the amount ');
          }
        },
        padding: EdgeInsets.symmetric(horizontal: 80.w, vertical: 15.h),
      ),
    );
  }

  Container _buildSubTotalContainer() {
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
        child: Text(
          "Sub Total (${widget.cartItems.length} items) : \$${calculateTotalPrice()}",
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 16,
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
