import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_27_03/Model/productModelList/product_model.dart';

import '../../../Model/Cart/addtocart.dart';
import '../../CartItems/cart_items.dart';

class ProductDetailsPage extends StatefulWidget {
  final int index;
  final int listindex;
  final String storename;
  final Subcategory items;

  const ProductDetailsPage({
    super.key,
    required this.index,
    required this.items,
    required this.storename,
    required this.listindex,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  PageController controller = PageController();
  int selectedIndex = 0;
  int countAddToCart = 0;

  @override
  Widget build(BuildContext context) {
    int totalItems = cartItems.length;
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
        title: const Text(
          'Product Details',
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Stack(
              children: [
                IconButton(
                  onPressed: () {
                    _navigateToCartPage();
                  },
                  icon: const Icon(Icons.shopping_cart, size: 27.0),
                ),
                Positioned(
                  top: 3,
                  right: 7,
                  child: Container(
                    height: 17.h,
                    width: 17.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.r),
                      color: Colors.green,
                    ),
                    child: Center(
                      child: Text(
                        totalItems.toString(),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(255, 255, 255, 0.34),
              Color.fromRGBO(255, 255, 255, 1),
            ],
          ),
        ),
        width: double.infinity,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 40.h),
          child: ElevatedButton.icon(
            onPressed: () {
              _addToCart();
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 13.h),
              backgroundColor: const Color(0xff44B12C),
            ),
            icon: const Icon(
              Icons.shopping_bag_rounded,
              color: Colors.white,
            ),
            label: Text(
              "Add to Cart",
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                productdetails(),
                const SizedBox(height: 15),
                productDescription(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container productDescription() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: const Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Product Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. karjasdnakljsndajlsnkjpdkkkssssssssssssssssssssssdddddddddddddddddddaaaaaaaaaaaaaaaa',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Container productdetails() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              padding: const EdgeInsets.only(top: 10),
              height: 179,
              child: Column(
                children: [
                  SizedBox(
                    height: 150,
                    child: PageView.builder(
                      onPageChanged: (value) {
                        setState(() {
                          selectedIndex = value;
                        });
                      },
                      controller: controller,
                      itemBuilder: (context, index) => Image.asset(
                        widget.items.imageurl,
                      ),
                      itemCount: 3,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                      (index) => Container(
                        margin: const EdgeInsets.only(right: 7),
                        height: 4,
                        width: 13,
                        color:
                            index == selectedIndex ? Colors.green : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.items.name,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ValueListenableBuilder(
                        valueListenable: widget.items.count,
                        builder: (context, value, child) => Text(
                              "\$ ${widget.items.price.value * widget.items.count.value}",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      height: 35,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(width: 1, color: Colors.green),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              if (widget.items.count.value > 1) {
                                widget.items.count.value--;
                                debugPrint(widget.items.count.value.toString());
                              }
                            },
                            child: const Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                            ),
                          ),
                          ValueListenableBuilder(
                            valueListenable: widget.items.count,
                            builder: (context, value, child) => Text(
                              widget.items.count.value.toString(),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              widget.items.count.value++;
                              debugPrint(widget.items.count.toString());
                            },
                            child: const Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(
                      "${widget.items.quantity} mg",
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _addToCart() {
    setState(() {
      cartItems.add({
        'categoryindex': widget.listindex,
        'key': widget.index,
        'shopName': widget.storename,
        'maindata': widget.items
      });

      // print(cartItems);
      Navigator.pop(context);
    });
    Fluttertoast.showToast(
        msg: "Added into cart",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void _navigateToCartPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            CartPage(cartItems: cartItems, storeName: widget.storename),
      ),
    );
  }
}
