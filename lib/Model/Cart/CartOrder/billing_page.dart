// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class RowSubtotal extends StatefulWidget {
  RowSubtotal({
    super.key,
    this.taxname,
    required this.price,
    this.discount,
    this.promoCode,
    this.total,
  });
  String? taxname;
  double price;
  double? discount;
  bool? promoCode;
  bool? total;
  @override
  State<RowSubtotal> createState() => _RowSubtotalState();
}

class _RowSubtotalState extends State<RowSubtotal> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.taxname.toString(),
              style: TextStyle(
                  color: const Color(0xff1E2231),
                  fontSize: 16,
                  fontWeight: widget.total == true
                      ? FontWeight.bold
                      : FontWeight.normal)),
          widget.discount != null
              ? Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: Text(
                      '\$3.00',
                      style: TextStyle(decoration: TextDecoration.lineThrough),
                    ),
                  ),
                  Text(
                    '\$${widget.price}',
                    style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xff1E2231),
                        fontWeight: FontWeight.w600),
                  ),
                ])
              : Text(
                  '\$${widget.price}',
                  style: TextStyle(
                      fontSize: 16,
                      color: widget.promoCode == true
                          ? Colors.red
                          : const Color(0xff1E2231),
                      fontWeight: FontWeight.w600),
                ),
        ],
      ),
    );
  }
}
