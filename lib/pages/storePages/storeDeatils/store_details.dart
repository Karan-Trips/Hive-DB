import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Model/Cart/addtocart.dart';
import '../../../Model/ReviewClass/review.dart';
import '../../../Model/widetsClass/card/widgets_class.dart';
import '../../../Model/widetsClass/reviewPage/widget_review.dart';
import '../../CartItems/cart_items.dart';

class StoreDetailPage extends StatefulWidget {
  const StoreDetailPage({
    super.key,
  });

  @override
  State<StoreDetailPage> createState() => _StoreDetailPageState();
}

class _StoreDetailPageState extends State<StoreDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int totalItems = cartItems.length;

    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final int? storeindex = arguments?['storeindex'];
    final String? storename = arguments?['storename'];
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_outlined),
                  color: Colors.white,
                ),
                title: Text(
                  "Store Details",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                centerTitle: true,
                actions: [
                  Stack(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CartPage(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.shopping_cart),
                        color: Colors.white,
                      ),
                      Positioned(
                        right: 5.w,
                        top: 5.h,
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
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                stretch: true,
                automaticallyImplyLeading: false,
                expandedHeight: 230,
                flexibleSpace: FlexibleSpaceBar(
                  background: SizedBox(
                    height: 250,
                    width: double.infinity,
                    child: Stack(children: [
                      Container(
                        height: 205.h,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              'https://www.indiafilings.com/learn/wp-content/uploads/2023/03/How-can-I-register-my-shop-and-establishment-online.jpg',
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.18,
                        left: MediaQuery.of(context).size.width * 0.05,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.88,
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, '/storeProductDetail', arguments: {
                                "storeindex": storeindex,
                                "storename": storename
                              });
                            },
                            child: HomeCardCustom(
                              index: storeindex as int,
                            ),
                          ),
                        ),
                      )
                    ]),
                  ),
                ),
              ),
            ];
          },
          body: DefaultTabController(
            length: 2,
            initialIndex: 0,
            child: Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TabBar(
                    labelStyle: TextStyle(
                        color: const Color(0xff272727).withOpacity(.5)),
                    padding: EdgeInsets.zero,
                    controller: controller,
                    labelPadding: EdgeInsets.only(right: 5.w, left: 5.w),
                    indicator: const BoxDecoration(color: Color(0xffF0F6EE)),
                    labelColor: Colors.green,
                    indicatorColor: Colors.transparent,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: [
                      Container(
                          color: const Color(0xffF0F6EE),
                          child: const Center(child: Tab(text: 'About Us'))),
                      Container(
                          color: const Color(0xffF0F6EE),
                          child: const Center(child: Tab(text: 'Reviews'))),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: controller,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(20.w),
                          child: const SingleChildScrollView(
                            child: Text(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                              maxLines: 19,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 200,
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "All Reviews (${reviews.length})",
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                    TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          "View all",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12.sp),
                                        )),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Column(
                                    children: List.generate(
                                        reviews.length,
                                        (index) => ReviewPage(
                                              index: index,
                                            )),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
