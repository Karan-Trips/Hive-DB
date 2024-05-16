import 'package:flutter/material.dart';
import 'package:task_27_03/pages/loginscreens/ProfilePage/edit_address.dart';

import '../Screen/get_started.dart';
import '../pages/loginscreens/add_details_page.dart';
import '../pages/loginscreens/mobile_login.dart';
import '../pages/loginscreens/otp_page.dart';
import '../pages/orderPages/manage_paymets.dart';
import '../pages/orderPages/place_order.dart';
import '../pages/storePages/chatPage/chat_screen.dart';
import '../pages/storePages/storeDeatils/main_screen.dart';
import '../pages/storePages/storeDeatils/store_details.dart';
import '../pages/storePages/storeDeatils/store_products.dart';

class RouteManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const GetStarted());
      case '/mobilelogin':
        return MaterialPageRoute(builder: (_) => const MobileLogin());
      case '/otp':
        return MaterialPageRoute(builder: (_) => const OtpPage());
      case '/detailpage':
        return MaterialPageRoute(builder: (_) => const DetailsPage());
      case '/mainscreen':
        return MaterialPageRoute(builder: (_) => const MainScreenPage());
      case '/storeProductDetail':
        return MaterialPageRoute(
            builder: (_) => const StoreProductDetail(), settings: settings);
      case '/edit_user_address':
        return MaterialPageRoute(
            builder: (_) => const EditUserAddress(), settings: settings);
      case '/storeChat':
        return MaterialPageRoute(
            builder: (_) => const ChatScreen(), settings: settings);
      case '/storeDetailpage':
        return MaterialPageRoute(
            builder: (_) => const StoreDetailPage(), settings: settings);
      case '/orderBillingPage':
        return MaterialPageRoute(
            builder: (_) => const PlaceAnOrder(), settings: settings);
      case '/managepayments':
        return MaterialPageRoute(
            builder: (_) => const ManagePaymentsDetails(), settings: settings);
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No route defined for ${settings.name}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Please check the route name or add the route in RouteManager class.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
    }
  }
}
