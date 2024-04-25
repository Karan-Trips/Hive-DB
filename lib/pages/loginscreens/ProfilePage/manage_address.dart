import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_27_03/pages/loginscreens/ProfilePage/add_address.dart';

class ManageAddressPage extends StatefulWidget {
  const ManageAddressPage({
    super.key,
  });

  @override
  State<ManageAddressPage> createState() => _ManageAddressPageState();
}

class _ManageAddressPageState extends State<ManageAddressPage> {
  @override
  void initState() {
    super.initState();
    _fetchUserAddresses();
  }

  Future<List<Map<dynamic, dynamic>>?> getUserAddresses() async {
    var box = await Hive.openBox('users_address');

    String? phoneno = await getphonono();
    List<dynamic>? addresses = await box.get(phoneno);
    // debugPrint(addresses.toString());
    if (addresses != null) {
      List<Map<dynamic, dynamic>> convertedAddresses =
          addresses.cast<Map<dynamic, dynamic>>().toList();
      return convertedAddresses;
    } else {
      return null;
    }
  }

  Future<void> deleteAddress(int index) async {
    var box = await Hive.openBox('users_address');

    String? phoneno = await getphonono();
    List<dynamic>? addresses = await box.get(phoneno);

    if (addresses != null && index >= 0 && index < addresses.length) {
      addresses.removeAt(index);
      await box.put(phoneno, addresses);
      setState(() {});
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

  bool isChecked = false;
  int radioValue = 0;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _fetchUserAddresses(),
        builder: (context, snapshot) {
          return Scaffold(
              backgroundColor: const Color(0xffF5F5F5),
              appBar: AppBar(
                leading: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.navigate_before,
                    size: 40.sp,
                    color: Colors.black,
                  ),
                ),
                title: Text(
                  "Manage Address",
                  style: TextStyle(
                    fontSize: 22.spMax,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
              ),
              body: Column(
                children: [
                  Column(
                    children: List.generate(
                      userAddresses?.length ?? 0,
                      (index) {
                        var address = userAddresses![index];

                        return Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(
                                top: 20.h,
                                bottom: 20.h,
                                right: 20.w,
                              ),
                              margin: EdgeInsets.only(
                                left: 15.w,
                                right: 15.w,
                                top: 15.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.r),
                                  topRight: Radius.circular(10.r),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Radio(
                                    value: index,
                                    fillColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.disabled)) {
                                          return Colors.green.withOpacity(.32);
                                        }
                                        return Colors.green;
                                      },
                                    ),
                                    groupValue: radioValue,
                                    onChanged: (value) {
                                      setState(() {
                                        radioValue = value!;
                                      });
                                    },
                                  ),
                                  Expanded(
                                    child: Text(
                                      address['unit'] +
                                          " " +
                                          address['address'] +
                                          " " +
                                          address['state'] +
                                          " " +
                                          address['city'] +
                                          " " +
                                          address['zipcode'],
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16.sp,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 15.w),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.all(10.h),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10.r),
                                        ),
                                        border: Border(
                                          top: BorderSide(
                                            color: Colors.grey.shade200,
                                            width: 1,
                                          ),
                                          right: BorderSide(
                                            color: Colors.grey.shade200,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                      child: InkWell(
                                        onTap: () async {
                                          await deleteAddress(index);
                                          setState(() {});
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 5.w,
                                              ),
                                              child: Icon(
                                                Icons.delete_outline,
                                                size: 25.h,
                                                color: Colors.red,
                                              ),
                                            ),
                                            Text(
                                              'Delete',
                                              style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 18.sp,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(right: 15.w),
                                      padding: EdgeInsets.all(10.h),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(10.r),
                                        ),
                                        color: Colors.white,
                                        border: Border(
                                          top: BorderSide(
                                            color: Colors.grey.shade200,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context,
                                            '/edit_user_address',
                                            arguments: index,
                                          );
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 5.w,
                                              ),
                                              child: Icon(
                                                Icons.edit,
                                                color: Colors.black54,
                                                size: 25.h,
                                              ),
                                            ),
                                            Text(
                                              'Change',
                                              style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 18.sp,
                                                color: const Color(0xff130101),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Center(
                    child: TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UserAddressDetails(),
                          ),
                        );
                      },
                      icon: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(width: 1, color: Colors.green),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.green,
                        ),
                      ),
                      label: const Text(
                        "Add New",
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ),
                ],
              ));
        });
  }
}
