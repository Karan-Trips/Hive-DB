import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_27_03/pages/loginscreens/ProfilePage/user_profile.dart';
import 'package:task_27_03/pages/storePages/storeDeatils/store_main_page.dart';

import '../../../Model/Cart/addtocart.dart';
import '../../loginscreens/ProfilePage/edit_profile.dart';

class MainScreenPage extends StatefulWidget {
  const MainScreenPage({super.key});

  @override
  State<MainScreenPage> createState() => _MainScreenPageState();
}

class _MainScreenPageState extends State<MainScreenPage>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
    controller.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    setState(() {
      selectedIndex = controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 5,
          surfaceTintColor: Colors.white,
          shadowColor: Colors.black,
          leading: const Icon(Icons.arrow_back_ios_new),
          actions: appBarActionBar(selectedIndex),
          title: appBarTitle(selectedIndex),
          centerTitle: true,
        ),
        body: TabBarView(controller: controller, children: const [
          StorePage(),
          Center(child: Text("My Order")),
          ProfilePage(),
        ]),
        bottomNavigationBar: BottomAppBar(
          padding: EdgeInsets.zero,
          shape: const CircularNotchedRectangle(),
          color: const Color(0xffF0F6EE).withOpacity(.94),
          child: TabBar(
            controller: controller,
            indicatorColor: Colors.green,
            labelColor: Colors.green,
            tabs: const [
              Tab(
                icon: Icon(Icons.home),
                text: 'Store',
              ),
              Tab(
                icon: Icon(Icons.list_alt_outlined),
                text: 'My Order',
              ),
              Tab(
                icon: Icon(Icons.person),
                text: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> appBarActionBar(int index) {
    int totalItems = cartItems.length;
    if (index == 0) {
      return [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Stack(
            children: [
              IconButton(
                onPressed: () {},
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
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ];
    } else if (index == 1) {
      return [];
    } else {
      return [
        IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserAddress(),
                ));
          },
          icon: const Icon(Icons.edit, size: 27.0),
        ),
      ];
    }
  }

  Widget appBarTitle(int index) {
    if (index == 0) {
      return const Text(
        "Huge Basket",
        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
      );
    } else if (index == 1) {
      return const Text(
        "My Orders",
        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
      );
    } else {
      return const Text(
        "Profile",
        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
      );
    }
  }
}
