// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_27_03/pages/loginscreens/ProfilePage/manage_address.dart';
import 'package:task_27_03/pages/loginscreens/ProfilePage/notification.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, IconData>> icons = [
      {
        "Manage Address": Icons.location_on,
      },
      {
        "Recent Chat": Icons.chat,
      },
      {
        "Notification": Icons.notifications,
      },
      {
        "Rate the App": Icons.star_border,
      },
      {
        "Share-App": Icons.share,
      },
      {
        "Help & FAQ": Icons.help,
      },
      {
        "About Us": Icons.person,
      },
      {
        "Terms & Conditions": Icons.list_alt_outlined,
      },
      {
        "Privacy Policy": Icons.privacy_tip_outlined,
      },
      {
        "Contact-Us": Icons.contact_phone,
      },
      {"Log-Out": Icons.login},
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
            itemCount: icons.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10, crossAxisSpacing: 10, crossAxisCount: 2),
            itemBuilder: (context, index) {
              final icon = icons[index];
              return Material(
                child: InkWell(
                  onTap: () async {
                    if (icon.keys.first == "Log-Out") {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      await preferences.remove('phoneno');
                      Navigator.popAndPushNamed(context, '/mobilelogin');
                    } else if (icon.keys.first == "Manage Address") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ManageAddressPage(),
                        ),
                      );
                    } else if (icon.keys.first == "Notification") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NotificationPage(),
                          ));
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: const Color(0xFFFFFFFF),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10.r,
                          color: const Color.fromRGBO(0, 0, 0, 0.08),
                          offset: const Offset(0, 0),
                          spreadRadius: 0.5,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          icon.values.first,
                          size: 50.w,
                          color: const Color(0xFF44B12C),
                        ),
                        Text(
                          icon.keys.first,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp,
                            color: const Color(0xFF1E2231),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
