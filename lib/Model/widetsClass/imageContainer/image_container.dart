import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../pages/storePages/storeDeatils/store_products.dart';
import '../../storeClass/store.dart';

class ImageContainer extends StatefulWidget {
  final int productindex;
  const ImageContainer({
    super.key,
    required this.widget,
    required this.searchController,
    required this.productindex,
  });

  final StoreProductDetail widget;
  final TextEditingController searchController;

  @override
  State<ImageContainer> createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 272.h,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: const NetworkImage(
            "https://www.indiafilings.com/learn/wp-content/uploads/2023/03/How-can-I-register-my-shop-and-establishment-online.jpg",
          ),
          onError: (exception, stackTrace) {
            debugPrint("Error = $exception");
          },
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          30.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Colors.white,
                  )),
              Text(
                storelist[widget.productindex].name,
                softWrap: true,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Stack(
                children: [
                  IconButton(
                    onPressed: () {},
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
                          "2",
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
          ),
          Center(
            child: _isLoading
                ? CircleAvatar(
                    radius: 40,
                    child: LottieBuilder.asset('assets/json/loading.json'))
                : CircleAvatar(
                    radius: 40,
                    backgroundImage:
                        NetworkImage(storelist[widget.productindex].image),
                  ),
          ),
          11.42.verticalSpace,
          Center(
            child: Text(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              storelist[widget.productindex].address,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.normal),
            ),
          ),
          11.verticalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              autocorrect: true,
              textInputAction: TextInputAction.search,
              keyboardType: TextInputType.name,
              controller: widget.searchController,
              onChanged: (value) {},
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 15.w),
                labelText: 'Search ${storelist[widget.productindex].name}',
                filled: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                fillColor: const Color(0xffF3F4F6),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(40)),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
