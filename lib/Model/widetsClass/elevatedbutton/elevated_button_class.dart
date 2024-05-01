// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Elevatedbutton extends StatelessWidget {
  Elevatedbutton({
    super.key,
    this.currentIndex,
    this.controller,
    this.padding,
    required this.txt,
    this.bgColors = Colors.green,
    required this.onPressed,
  });

  final int? currentIndex;
  final String txt;
  Color bgColors;
  final EdgeInsetsGeometry? padding;
  final PageController? controller;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 39.w),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: bgColors, padding: padding),
          onPressed: onPressed,
          child: Text(
            txt,
            style: const TextStyle(color: Colors.white),
          )),
    );
  }
}
