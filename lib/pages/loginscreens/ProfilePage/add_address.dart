// ignore_for_file: use_build_context_synchronously

import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/stacked_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_27_03/Model/widetsClass/elevatedbutton/elevated_button_class.dart';
import 'package:task_27_03/Model/widetsClass/textFormFeild/textformfield.dart';

extension ValidationExtension on TextEditingController {
  String? validateEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field cannot be empty';
    }
    return null;
  }

  String? validateLength(String? value, int minLength) {
    if (value == null || value.length < minLength) {
      return 'Field must be at least $minLength characters long';
    }
    return null;
  }

  String? validateZipcode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Zipcode cannot be empty';
    }

    final RegExp regex = RegExp(r'^\d{5}$');
    if (!regex.hasMatch(value)) {
      return 'Invalid zipcode';
    }
    return null;
  }
}

class UserAddressDetails extends StatefulWidget {
  const UserAddressDetails({super.key});

  @override
  State<UserAddressDetails> createState() => _UserAddressDetailsState();
}

class _UserAddressDetailsState extends State<UserAddressDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  GlobalKey<FormState> addressformkey = GlobalKey<FormState>();
  final address = TextEditingController();
  final unitno = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final zipcode = TextEditingController();
  final deliveryInst = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return _buildAddressForm(context);
  }

  Widget _buildAddressForm(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios_new_outlined)),
        title: const Text(
          "Add New Address",
          style: TextStyle(
              color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: addressformkey,
            child: Column(
              children: [
                30.verticalSpace,
                Textfield(
                    suficIcon: Icons.location_on,
                    controller: address,
                    labeltxt: "Address",
                    validator: (value) {
                      return address.validateEmpty(value) ??
                          address.validateLength(value, 5);
                    },
                    inputAction: TextInputAction.next,
                    keyboradtype: TextInputType.text),
                15.verticalSpace,
                Textfield(
                    controller: unitno,
                    labeltxt: "Enter Unit Number",
                    validator: unitno.validateEmpty,
                    inputAction: TextInputAction.next,
                    keyboradtype: TextInputType.number),
                15.verticalSpace,
                Textfield(
                    controller: city,
                    labeltxt: "City",
                    validator: city.validateEmpty,
                    inputAction: TextInputAction.next,
                    keyboradtype: TextInputType.name),
                15.verticalSpace,
                Textfield(
                    controller: state,
                    labeltxt: "State",
                    validator: state.validateEmpty,
                    inputAction: TextInputAction.next,
                    keyboradtype: TextInputType.name),
                15.verticalSpace,
                Textfield(
                    controller: zipcode,
                    labeltxt: "Zipcode",
                    validator: zipcode.validateZipcode,
                    inputAction: TextInputAction.next,
                    keyboradtype: TextInputType.number),
                15.verticalSpace,
                Textfield(
                    controller: deliveryInst,
                    maxline: 5,
                    labeltxt: "Delivery Instruction(Optional)",
                    validator: (p0) {
                      return null;
                    },
                    inputAction: TextInputAction.done,
                    keyboradtype: TextInputType.multiline),
                70.verticalSpace,
                SizedBox(
                  height: 52.h,
                  width: double.infinity,
                  child: Elevatedbutton(
                    txt: "Add",
                    onPressed: () {
                      if (addressformkey.currentState!.validate()) {
                        _saveAddressDetails();
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _saveAddressDetails() async {
    SharedPreferences prif = await SharedPreferences.getInstance();
    var phoneno = prif.getString('phoneno');

    if (phoneno != null) {
      var box = await Hive.openBox('users_address');
      List<Map<dynamic, dynamic>>? userAddresses =
          box.get(phoneno)?.cast<Map<dynamic, dynamic>>();

      userAddresses = userAddresses ?? [];

      userAddresses.add({
        'address': address.text,
        'unit': unitno.text,
        'city': city.text,
        'state': state.text,
        'zipcode': zipcode.text,
        'instruction': deliveryInst.text,
      });

      box.put(phoneno, userAddresses);
    }
    ElegantNotification.success(
      width: 360,
      isDismissable: false,
      stackedOptions: StackedOptions(
        key: 'top',
        type: StackedType.above,
        itemOffset: const Offset(-5, -5),
      ),
      title: const Text('Added'),

      description: const Text('Details Added successfully'),
      onDismiss: () {},
      // onNotificationPressed: () {},
      border: const Border(
        bottom: BorderSide(
          color: Colors.green,
          width: 2,
        ),
      ),
    ).show(context);
    // var snackBar = const SnackBar(
    //     backgroundColor: Colors.red, content: Text('Details Add'));
    // ScaffoldMessenger.of(context).showSnackBar(snackBar);

    Navigator.pop(context);
  }
}
