// ignore_for_file: must_be_immutable

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_27_03/Model/widetsClass/elevatedbutton/elevated_button_class.dart';
import '../../Model/Cart/CartOrder/billing_page.dart';

class PlaceAnOrder extends StatefulWidget {
  const PlaceAnOrder({super.key});

  @override
  State<PlaceAnOrder> createState() => _PlaceAnOrderState();
}

class _PlaceAnOrderState extends State<PlaceAnOrder> {
  int selectedAddressIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF5F5F5),
        appBar: AppBar(
          backgroundColor: const Color(0xffF5F5F5),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new_sharp)),
          centerTitle: true,
          title: const Text(
            'Place Your Order',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
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
                      // spreadRadius: 5,
                      blurStyle: BlurStyle.inner)
                ],
              ),
              child: const Center(
                child: Text(
                  "Next delivery on Wed, 14 Nov 2020",
                  style: TextStyle(
                    color: Color(0xff44B12C),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            10.verticalSpace,
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Enter the code here',
                                floatingLabelStyle:
                                    TextStyle(color: Colors.black),
                                border: InputBorder.none)),
                        DottedBorder(
                            dashPattern: const [
                              3,
                              5,
                            ],
                            borderPadding: const EdgeInsets.all(2),
                            child: Container())
                      ],
                    ),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Apply',
                        style: TextStyle(color: Colors.green, fontSize: 16),
                      ))
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              color: Colors.white,
              child: Column(
                children: [
                  RowSubtotal(
                    taxname: 'Sub Total',
                    price: 60.00,
                  ),
                  const SizedBox(height: 8.0),
                  RowSubtotal(
                    taxname: 'Tax',
                    price: 10.00,
                  ),
                  const SizedBox(height: 8.0),
                  RowSubtotal(taxname: 'Service Fee', price: 0.00, discount: 3),
                  const SizedBox(height: 8.0),
                  RowSubtotal(
                      taxname: 'Delivery Fees', price: 0.00, discount: 2),
                  const Divider(),
                  RowSubtotal(
                    taxname: 'Total Amount',
                    price: 65.50,
                  ),
                  const SizedBox(height: 8.0),
                  RowSubtotal(
                    taxname: 'Promo Applied (OFF20%)',
                    price: -13.00,
                    promoCode: true,
                  ),
                  const SizedBox(height: 8.0),
                  RowSubtotal(
                    price: 52.00,
                    taxname: 'Total Amount',
                    total: true,
                  ),
                ],
              ),
            ),
            15.verticalSpace,
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 3,
                    offset: Offset(0, 0),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20, top: 8, bottom: 8),
                    child: Text(
                      'Shipping',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                  Column(
                    children: List.generate(
                      2,
                      (index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedAddressIndex = index;
                          });
                        },
                        child: addressContainer(index),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(50),
                                  border:
                                      Border.all(color: Colors.green, width: 2),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.green,
                                    size: 16,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                'Add New',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: const Text(
                            'Manage Address',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 3,
                  offset: Offset(0, 0),
                )
              ]),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 20, top: 8, bottom: 8),
                      child: Text(
                        'Payment information',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                    Column(
                        children: List.generate(
                      1,
                      (index) {
                        return Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 3,
                                    offset: Offset(0, 0),
                                  )
                                ]),
                            child: Row(children: [
                              Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: Image.asset(
                                  'assets/images/mastercard@3x.png',
                                  width: 50,
                                ),
                              ),
                              10.verticalSpace,
                              const Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Anthony Bailey",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey),
                                    ),
                                    Text(
                                      "•••• •••• •••• 5678",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey),
                                    ),
                                  ],
                                ),
                              )
                            ]));
                      },
                    )),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                          color: Colors.green, width: 2)),
                                  child: const Center(
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.green,
                                      size: 16,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  'Add New',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, "/managepayments");
                            },
                            child: const Text(
                              'Change Card',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
            ),
            18.verticalSpace,
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Elevatedbutton(
                padding:
                    EdgeInsets.symmetric(horizontal: 120.w, vertical: 15.h),
                txt: "Place Order",
                onPressed: () {},
              ),
            )
          ]),
        ));
  }

  Container addressContainer(int index) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 3,
              offset: Offset(0, 0),
            )
          ]),
      child: Column(children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Radio(
                value: index,
                fillColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return Colors.green.withOpacity(.32);
                    }
                    return Colors.green;
                  },
                ),
                groupValue: selectedAddressIndex,
                onChanged: (value) {
                  setState(() {
                    selectedAddressIndex = value!;
                  });
                },
              ),
            ),
            15.verticalSpace,
            Flexible(
              child: Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                "${index}799 Lost Creek Road,Seattle , Fort Washington, Us, 19034 ",
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
            )
          ],
        ),
      ]),
    );
  }
}
