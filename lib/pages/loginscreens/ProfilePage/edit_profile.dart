// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localstorage/localstorage.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_27_03/pages/loginscreens/add_details_page.dart';
import '../../../Model/widetsClass/elevatedbutton/elevated_button_class.dart';
import '../../../Model/widetsClass/textFormFeild/textformfield.dart';

class UserAddress extends StatefulWidget {
  const UserAddress({super.key});

  @override
  State<UserAddress> createState() => _UserAddressState();
}

class _UserAddressState extends State<UserAddress> {
  String? validateField(value) {
    final RegExp nameRegex = RegExp(r'^[a-zA-Z]');
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    } else if (!nameRegex.hasMatch(value)) {
      return 'Name not valid';
    }
    return null;
  }

  // LocalStorage localStorage = localStorage.getItems();
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController bname = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController lname = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController zipcode = TextEditingController();
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? phoneno = prefs.getString('phoneno');

    // var box = await Hive.openBox('user_data');

    // var userData = await box.get(phoneno);
    var userDataJson = localStorage.getItem(phoneno!);
    if (userDataJson != null) {
      Map<String, dynamic> userData = jsonDecode(userDataJson);
      setState(() {
        bname.text = userData['businessName'];
        name.text = userData['firstName'];
        lname.text = userData['lastName'];
        email.text = userData['email'];
        phone.text = userData['phone'];
        zipcode.text = userData['zipcode'];
        // print('${userData['firstName']}');
      });
    } else {
      debugPrint('No user data found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
        title: const Text("Edit Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              30.verticalSpace,
              Textfield(
                inputAction: TextInputAction.next,
                keyboradtype: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter business name';
                  }
                  return null;
                },
                controller: bname,
                labeltxt: "Business Name",
              ),
              15.verticalSpace,
              Textfield(
                inputAction: TextInputAction.next,
                keyboradtype: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter first name';
                  } else if (!value.isValidName()) {
                    return 'Please enter a valid first name';
                  }
                  return null;
                },
                controller: name,
                labeltxt: "First Name",
              ),
              15.verticalSpace,
              Textfield(
                inputAction: TextInputAction.next,
                keyboradtype: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  } else if (!value.isValidName()) {
                    return 'Please enter a valid last name';
                  }
                  return null;
                },
                controller: lname,
                labeltxt: "Last Name",
              ),
              15.verticalSpace,
              Textfield(
                inputAction: TextInputAction.next,
                keyboradtype: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email address';
                  } else if (!value.isValidEmail()) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                controller: email,
                labeltxt: "Email Address",
              ),
              15.verticalSpace,
              Textfield(
                inputAction: TextInputAction.next,
                keyboradtype: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  } else if (value.length < 10 || value.length > 11) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                controller: phone,
                labeltxt: "Phone Number",
                prefixIcon: Icons.phone,
              ),
              15.verticalSpace,
              Textfield(
                inputAction: TextInputAction.done,
                keyboradtype: TextInputType.text,
                validator: (value) {
                  return null;
                },
                controller: address,
                labeltxt: "Address",
              ),
              142.verticalSpace,
              SizedBox(
                height: 52.h,
                width: double.infinity,
                child: Elevatedbutton(
                  txt: "Update",
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    String? phoneno = prefs.getString('phoneno');
                    if (formKey.currentState!.validate()) {
                      // var box = await Hive.openBox('user_data');

                      Map<String, dynamic> userDataProfile = {
                        'businessName': bname.text,
                        'firstName': name.text,
                        'lastName': lname.text,
                        'email': email.text,
                        'phone': phone.text,
                        'zipcode': zipcode.text,
                      };
                      String userDataProfileJson = jsonEncode(userDataProfile);

                      localStorage.setItem(phoneno!, userDataProfileJson);
                      // await box.put(phoneno, userDataProfile);
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
