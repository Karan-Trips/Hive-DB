// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/stacked_options.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/widetsClass/elevatedbutton/elevated_button_class.dart';
import '../../Model/widetsClass/textFormFeild/textformfield.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(this);
  }
}

extension NameValidator on String {
  bool isValidName() {
    final RegExp nameRegex = RegExp(r'^[a-zA-Z]');
    return nameRegex.hasMatch(this);
  }
}

extension ZipCodeValidator on String {
  bool isValidZipCode() {
    final RegExp zipCodeRegex = RegExp(r'^\d{5}(?:[-\s]\d{4})?$');
    return zipCodeRegex.hasMatch(this);
  }
}

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  // SharedPrefData sharedPrefData = SharedPrefData();
  bool agree = false;
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController bname = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController zipcode = TextEditingController();
  TextEditingController phone = TextEditingController();
  void saveFormData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var sharedPrefData = prefs.getString('phoneno');
    // debugPrint(sharedPrefData.toString());
    if (formKey.currentState!.validate()) {
      // var box = await Hive.openBox('user_data');//HIVE DB

      Map<String, dynamic> userDataProfile = {
        'businessName': bname.text,
        'firstName': name.text,
        'lastName': lname.text,
        'email': email.text,
        'phone': phone.text,
        'zipcode': zipcode.text,
      };
      String userDataProfileJson = jsonEncode(userDataProfile);

      localStorage.setItem(
          sharedPrefData!, userDataProfileJson); //LocalStorage DB
      // await box.put(sharedPrefData, userDataProfile);//Hive DB
      ElegantNotification.success(
        width: 360,
        isDismissable: false,
        stackedOptions: StackedOptions(
          key: 'top',
          type: StackedType.same,
          itemOffset: const Offset(-5, -5),
        ),
        title: const Text('Added'),
        description: const Text('Details Added successfully'),
        onDismiss: () {},
        onNotificationPressed: () {},
        border: const Border(
          bottom: BorderSide(
            color: Colors.green,
            width: 2,
          ),
        ),
      ).show(context);

      Navigator.pushNamedAndRemoveUntil(
          context, '/mainscreen', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, '/mobilelogin');
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined)),
        title: const Text(
          "Add More Details",
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
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
                    return 'Please enter your business name';
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
                    return 'Please enter your first name';
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
                keyboradtype: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your zip code';
                  } else if (!value.isValidZipCode()) {
                    return 'Please enter a valid zip code';
                  }
                  return null;
                },
                controller: zipcode,
                labeltxt: "ZipCode",
              ),
              12.verticalSpace,
              Container(
                margin: EdgeInsets.symmetric(horizontal: 39.h),
                child: Row(
                  children: [
                    Checkbox(
                      value: agree,
                      onChanged: (value) {
                        setState(() {
                          agree = value!;
                        });
                      },
                    ),
                    const Text("I agree to the",
                        style: TextStyle(fontSize: 15)),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Terms & Condition",
                          style: TextStyle(color: Colors.green, fontSize: 15),
                        ))
                  ],
                ),
              ),
              20.verticalSpace,
              SizedBox(
                  height: 52.h,
                  width: double.infinity,
                  child: Elevatedbutton(txt: "Add", onPressed: saveFormData))
            ],
          ),
        ),
      ),
    );
  }
}
