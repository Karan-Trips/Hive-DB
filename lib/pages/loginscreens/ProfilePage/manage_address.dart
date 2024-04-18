import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ManageAddressPage extends StatefulWidget {
  const ManageAddressPage({super.key});

  @override
  State<ManageAddressPage> createState() => _ManageAddressPageState();
}

class _ManageAddressPageState extends State<ManageAddressPage> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.navigate_before,
              size: 40.sp,
              color: Colors.black,
            )),
        title: Text(
          "Manage Address",
          style: TextStyle(
              fontSize: 22.spMax,
              color: Colors.green,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        toolbarHeight: 110.h,
        elevation: 5,
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0.4, 0.4))
                    ],
                  ),
                  child: Column(
                    children: [
                      20.verticalSpace,
                      Row(
                        children: [
                          Radio(
                            value: isChecked,
                            groupValue: 0,
                            onChanged: (value) {
                              setState(() {
                                isChecked = !isChecked;
                              });
                            },
                          ),
                          14.horizontalSpace,
                          SizedBox(
                            height: 53.h,
                            width: 264.w,
                            child: Text(
                              maxLines: 2,
                              "799 Lost Creek Road,Seattle , Fort Washington, Us, 19034",
                              style: TextStyle(fontSize: 14.spMax),
                            ),
                          ),
                        ],
                      ),
                      34.verticalSpace,
                      const Divider(),
                      SizedBox(
                        height: 40,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 52, right: 46),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  Text(
                                    "Delete",
                                    style: TextStyle(fontSize: 16.spMax),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.edit),
                                  Text(
                                    "Change",
                                    style: TextStyle(fontSize: 16.spMax),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          37.verticalSpace,
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.add_circle_outline_rounded,
              color: Colors.green,
            ),
            label: const Text(
              "Add New",
              style: TextStyle(color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }
}
