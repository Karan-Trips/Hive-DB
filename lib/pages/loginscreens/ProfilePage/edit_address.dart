// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_27_03/Model/widetsClass/elevatedbutton/elevated_button_class.dart';
import 'package:task_27_03/Model/widetsClass/textFormFeild/textformfield.dart';

class EditUserAddress extends StatefulWidget {
  const EditUserAddress({super.key});

  @override
  State<EditUserAddress> createState() => _EditUserAddressState();
}

class _EditUserAddressState extends State<EditUserAddress> {
  late int addressindex;
  @override
  void dispose() {
    super.dispose();
  }

  GlobalKey<FormState> addressformkey = GlobalKey<FormState>();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getAddressIndex();
    });

    super.initState();
  }

  final address = TextEditingController();
  final unitno = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final zipcode = TextEditingController();
  final deliveryInst = TextEditingController();
  void getAddressIndex() {
    var data = ModalRoute.of(context)!.settings.arguments;
    if (data is int) {
      setState(() {
        addressindex = data;
      });
      getUserAddresses();
    } else {
      debugPrint("something went worng");
    }
  }

  Future getUserAddresses() async {
    var box = await Hive.openBox('users_address');

    String? token = await _getToken();
    List<dynamic>? addresses = await box.get(token);
    if (addresses != null) {
      List<Map<dynamic, dynamic>> convertedAddresses =
          addresses.cast<Map<dynamic, dynamic>>().toList();
      setState(() {
        address.text = convertedAddresses[addressindex]['address'] ?? '';
        unitno.text = convertedAddresses[addressindex]['unit'] ?? '';
        city.text = convertedAddresses[addressindex]['city'] ?? '';
        state.text = convertedAddresses[addressindex]['state'] ?? '';
        zipcode.text = convertedAddresses[addressindex]['zipcode'] ?? '';
        deliveryInst.text =
            convertedAddresses[addressindex]['instruction'] ?? '';
      });
    } else {
      return null;
    }
  }

  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('phoneno');
  }

  @override
  Widget build(BuildContext context) {
    return _buildAddressForm(context);
  }

  Widget _buildAddressForm(BuildContext context) {
    // int addressIndex = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios_new_outlined)),
        title: const Text(
          "Edit Address",
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
                    validator: (p0) {
                      return null;
                    },
                    inputAction: TextInputAction.next,
                    keyboradtype: TextInputType.text),
                15.verticalSpace,
                Textfield(
                    controller: unitno,
                    labeltxt: "Enter Unit Number",
                    validator: (p0) {
                      return null;
                    },
                    inputAction: TextInputAction.next,
                    keyboradtype: TextInputType.text),
                15.verticalSpace,
                Textfield(
                    controller: city,
                    labeltxt: "City",
                    validator: (p0) {
                      return null;
                    },
                    inputAction: TextInputAction.next,
                    keyboradtype: TextInputType.text),
                15.verticalSpace,
                Textfield(
                    controller: state,
                    labeltxt: "State",
                    validator: (p0) {
                      return null;
                    },
                    inputAction: TextInputAction.next,
                    keyboradtype: TextInputType.text),
                15.verticalSpace,
                Textfield(
                    controller: zipcode,
                    labeltxt: "Zipcode",
                    validator: (p0) {
                      return null;
                    },
                    inputAction: TextInputAction.next,
                    keyboradtype: TextInputType.text),
                15.verticalSpace,
                Textfield(
                    controller: deliveryInst,
                    maxline: 5,
                    labeltxt: "Delivery Instruction",
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
                    onPressed: () async {
                      if (addressformkey.currentState!.validate()) {
                        // _saveAddressDetails();
                        var box = await Hive.openBox('users_address');
                        String? token = await _getToken();
                        List<dynamic>? addresses = await box.get(token);
                        if (addresses != null) {
                          List<Map<dynamic, dynamic>> convertedAddresses =
                              addresses.cast<Map<dynamic, dynamic>>().toList();

                          convertedAddresses[addressindex] = {
                            'address': address.text,
                            'unit': unitno.text,
                            'city': city.text,
                            'state': state.text,
                            'zipcode': zipcode.text,
                            'instruction': deliveryInst.text,
                          };

                          await box.put(token, convertedAddresses);

                          Navigator.pop(context);
                        }
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
}
