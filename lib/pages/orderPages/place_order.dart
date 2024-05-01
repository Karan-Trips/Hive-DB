// ignore_for_file: must_be_immutable
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_27_03/Model/widetsClass/elevatedbutton/elevated_button_class.dart';
import '../../Model/Cart/CartOrder/billing_page.dart';
import '../loginscreens/ProfilePage/add_address.dart';

class PlaceAnOrder extends StatefulWidget {
  const PlaceAnOrder({super.key});

  @override
  State<PlaceAnOrder> createState() => _PlaceAnOrderState();
}

class _PlaceAnOrderState extends State<PlaceAnOrder> {
  int selectedAddressIndex = 0;
  String promocode = '202K';
  @override
  void initState() {
    super.initState();
    _fetchUserAddresses();
  }

  Future<List<Map<dynamic, dynamic>>?> getUserAddresses() async {
    var box = await Hive.openBox('users_address');

    String? phoneno = await getphonono();
    List<dynamic>? addresses = await box.get(phoneno);

    if (addresses != null) {
      List<Map<dynamic, dynamic>> convertedAddresses =
          addresses.cast<Map<dynamic, dynamic>>().toList();
      return convertedAddresses;
    } else {
      return null;
    }
  }

  Future<String?> getphonono() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('phoneno');
  }

  List<Map<dynamic, dynamic>>? userAddresses;

  Future<void> _fetchUserAddresses() async {
    List<Map<dynamic, dynamic>>? addresses = await getUserAddresses();
    if (addresses != null) {
      setState(() {
        userAddresses = addresses;
      });
    } else {
      return debugPrint('No user data found for phoneno: ');
    }
  }

  bool promoBool = false;

  TextEditingController controller = TextEditingController();
  double tax = 10.00;
  double promo = 13.00;
  @override
  Widget build(BuildContext context) {
    double cartItms = ModalRoute.of(context)!.settings.arguments as double;

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
        body: FutureBuilder(
            future: _fetchUserAddresses(),
            builder: (context, snapshot) {
              return SingleChildScrollView(
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
                      child: promoBool
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 7),
                                  decoration: BoxDecoration(
                                      color: Colors.greenAccent,
                                      borderRadius: BorderRadius.circular(4)),
                                  child: const Text(
                                    "Flat 10%",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17),
                                  ),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                Container(
                                  height: 22,
                                  width: 22,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1.5, color: Colors.black),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        promoBool = false;
                                      });
                                    },
                                    child: const Center(
                                      child: Icon(
                                        Icons.close,
                                        size: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      TextFormField(
                                          controller: controller,
                                          decoration: const InputDecoration(
                                              labelText: 'Enter the code here',
                                              floatingLabelStyle: TextStyle(
                                                  color: Colors.black),
                                              border: InputBorder.none)),
                                      DottedBorder(
                                          dashPattern: const [
                                            3,
                                            5,
                                          ],
                                          borderPadding:
                                              const EdgeInsets.all(2),
                                          child: Container())
                                    ],
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        if (controller.text == '202k') {
                                          promoBool = true;
                                          print(promoBool);
                                          controller.clear();
                                        }
                                      });
                                    },
                                    child: const Text(
                                      'Apply',
                                      style: TextStyle(
                                          color: Colors.green, fontSize: 16),
                                    ))
                              ],
                            )),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    color: Colors.white,
                    child: Column(
                      children: [
                        RowSubtotal(
                          taxname: 'Sub Total',
                          price: cartItms,
                        ),
                        const SizedBox(height: 8.0),
                        RowSubtotal(
                          taxname: 'Tax',
                          price: tax,
                        ),
                        const SizedBox(height: 8.0),
                        RowSubtotal(
                            taxname: 'Service Fee', price: 0.00, discount: 3),
                        const SizedBox(height: 8.0),
                        RowSubtotal(
                            taxname: 'Delivery Fees', price: 0.00, discount: 2),
                        const Divider(),
                        Visibility(
                          visible: promoBool,
                          child: RowSubtotal(
                            taxname: 'Total Amount',
                            price: cartItms,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Visibility(
                          visible: promoBool,
                          child: RowSubtotal(
                            taxname: 'Promo Applied (OFF20%)',
                            price: -promo,
                            promoCode: true,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        RowSubtotal(
                          price: promoBool
                              ? cartItms - tax - promo
                              : cartItms - tax,
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
                            userAddresses?.length ?? 0,
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
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const UserAddressDetails(),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                            color: Colors.green, width: 2),
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
                    decoration:
                        const BoxDecoration(color: Colors.white, boxShadow: [
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
                            padding:
                                EdgeInsets.only(left: 20, top: 8, bottom: 8),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                            borderRadius:
                                                BorderRadius.circular(50),
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
                                    Navigator.pushNamed(
                                        context, "/managepayments");
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
                      padding: EdgeInsets.symmetric(
                          horizontal: 120.w, vertical: 15.h),
                      txt: "Place Order",
                      onPressed: () {},
                    ),
                  )
                ]),
              );
            }));
  }

  Container addressContainer(int index) {
    var address = userAddresses![index];
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
                "${address['unit'] + " " + address['address'] + " " + address['state'] + " " + address['city'] + " " + address['zipcode']}",
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
