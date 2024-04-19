import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../Model/storeClass/store.dart';
import '../../../Model/widetsClass/card/widgets_class.dart';

class StorePage extends StatefulWidget {
  const StorePage({
    super.key,
  });

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 0)), //TODO:Change the time
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: LottieBuilder.asset('assets/json/waiting.json'),
            ),
          );
        } else {
          return SingleChildScrollView(
            // physics: const BouncingScrollPhysics(),
            child: Column(
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
                      )
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      "Next delivery on Wed, 14 Nov 2020",
                      style: TextStyle(
                        color: Color(0xff44B12C),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                10.verticalSpace,
                Column(
                  children: List.generate(
                    storelist.length,
                    (index) => InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/storeDetailpage',
                          arguments: {
                            'storeindex': index,
                            'storename': storelist[index].name,
                          },
                        );
                      },
                      child: HomeCardCustom(index: index),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
