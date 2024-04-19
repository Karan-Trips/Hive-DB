import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:task_27_03/Model/storeClass/store.dart';

class HomeCardCustom extends StatefulWidget {
  const HomeCardCustom({
    super.key,
    required this.index,
  });
  final int index;

  @override
  State<HomeCardCustom> createState() => _HomeCardCustomState();
}

class _HomeCardCustomState extends State<HomeCardCustom> {
  bool _isLoading = true;
  late Future<void> loading;

  @override
  void initState() {
    super.initState();
    loading = Future.delayed(const Duration(seconds: 0), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    loading;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95.h,
      margin: EdgeInsets.symmetric(horizontal: 20.h, vertical: 15.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 7),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Row(children: [
          SizedBox(
            height: 95,
            width: 69,
            child: Stack(children: [
              Align(
                alignment: Alignment.center,
                child: _isLoading
                    ? LottieBuilder.asset('assets/json/loading.json')
                    : Container(
                        height: 70,
                        // width: 69.r,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          // color: Colors.red,
                          image: DecorationImage(
                            image: NetworkImage(storelist[widget.index].image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
              ),
              Positioned(
                bottom: 8,
                left: 22,
                child: Container(
                  width: 30,
                  height: 16,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.star,
                          size: 8,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          storelist[widget.index].rating,
                          style:
                              const TextStyle(color: Colors.white, fontSize: 8),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ]),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 20, right: 15, left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        storelist[widget.index].name,
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        storelist[widget.index].distance,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      )
                    ],
                  ),
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    storelist[widget.index].subtitle,
                    style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    storelist[widget.index].address,
                    style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  )
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
