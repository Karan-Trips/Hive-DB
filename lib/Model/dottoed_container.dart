import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DottedContainer extends StatelessWidget {
  const DottedContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 26.r,
      width: 26.r,
      decoration: BoxDecoration(
          color: const Color.fromRGBO(68, 177, 44, 0.1),
          borderRadius: BorderRadius.circular(50)),
      child: const Center(
          child: Icon(
        Icons.add,
        color: Colors.green,
      )),
    );
  }
}
