import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:task_27_03/Model/widetsClass/elevatedbutton/elevated_button_class.dart';
import 'package:task_27_03/Model/widetsClass/textFormFeild/textformfield.dart';


class UserAddressDetails extends StatefulWidget {
  const UserAddressDetails({super.key});

  @override
  State<UserAddressDetails> createState() => _UserAddressDetailsState();
}

class _UserAddressDetailsState extends State<UserAddressDetails> {
  late Box<Map<dynamic, dynamic>> addressBox;

  @override
  void initState() {
    super.initState();
    _openAddressBox();
  }

  void _openAddressBox() async {
    addressBox = await Hive.openBox('user_address');  
  }

  @override
  void dispose() {
    addressBox.close();
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

  Scaffold _buildAddressForm(BuildContext context) {
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

  void _saveAddressDetails() {
    final userAddress = {
      'address': address.text,
      'unitNumber': unitno.text,
      'city': city.text,
      'state': state.text,
      'zipcode': zipcode.text,
      'deliveryInstruction': deliveryInst.text,
    };

    if (addressBox.isOpen) {
      addressBox.put('user_address', userAddress);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Address saved')),
      );
    } else {
      print('Error: Box is not open.');
    }
  }
}
