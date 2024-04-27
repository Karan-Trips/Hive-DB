import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_27_03/Model/widetsClass/elevatedbutton/elevated_button_class.dart';

class CartPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final String storename;

  const CartPage({super.key, required this.cartItems, required this.storename});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Map<String, List<Map<String, dynamic>>> itemsByShop = {};

  @override
  Widget build(BuildContext context) {
    Map<String, List<Map<String, dynamic>>> itemsByShop = {};
    for (Map<String, dynamic> item in widget.cartItems) {
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
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_sharp)),
        centerTitle: true,
        title: const Text(
          'View Cart',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 45.h,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.06),
              boxShadow: [
                BoxShadow(
                    color: Color(0xffF0F6EE),
                    offset: Offset(0, 3),
                    blurRadius: 10,
                    // spreadRadius: 5,
                    blurStyle: BlurStyle.inner)
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
          ),
          5.verticalSpace,
          Container(
            width: double.infinity,
            height: 45.h,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.06),
              boxShadow: [
                BoxShadow(
                    color: Color(0xffF0F6EE),
                    offset: Offset(0, 3),
                    blurRadius: 10,
                    blurStyle: BlurStyle.inner)
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Text(
                "Sub Total (${widget.cartItems.length} items) : \$60",
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(10.sp),
            child: ListView(
              shrinkWrap: true,
              children: [
                for (String shopName in itemsByShop.keys)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        child: Text(
                          shopName,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: itemsByShop[shopName]!.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> item =
                              itemsByShop[shopName]![index];
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          item['name'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {},
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
                                            margin: const EdgeInsets.only(
                                                right: 23, bottom: 17),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
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
                                          margin: const EdgeInsets.only(
                                              right: 23, bottom: 17),
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
                                            margin: const EdgeInsets.only(
                                                right: 23, bottom: 17),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
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
                        },
                      ),
                    ],
                  ),
                if (itemsByShop.length < widget.cartItems.length)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.cartItems.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> item = widget.cartItems[index];
                          if (!itemsByShop.containsKey(item['shopName'])) {
                            return ListTile(
                              leading: Image.asset(item['imgUrl']),
                              title: Text('Product: ${item['name']}'),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Shop: ${item['shopName']}'),
                                  Text('Quantity: ${item['quantity']}'),
                                  Text('mg: ${item['mg']}'),
                                  Text('Price: \$ ${item['price']}'),
                                ],
                              ),
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                    ],
                  ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Elevatedbutton(
              txt: 'Proceed to Checkout',
              onPressed: () {
                Navigator.pushNamed(context, "/orderBillingPage");
              },
              padding: EdgeInsets.symmetric(horizontal: 90.w, vertical: 15.h),
            ),
          )
        ],
      ),
    );
  }
}
