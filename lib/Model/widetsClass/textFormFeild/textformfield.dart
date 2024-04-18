import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Textfield extends StatelessWidget {
  const Textfield({
    super.key,
    required this.controller,
    this.maxline,
    required this.labeltxt,
    required this.validator,
    required this.inputAction,
    this.prefixIcon,
    this.suficIcon,
    required this.keyboradtype,
  });

  final TextEditingController controller;
  final IconData? prefixIcon;
  final IconData? suficIcon;
  final int? maxline;
  final String labeltxt;
  final TextInputAction inputAction;
  final TextInputType keyboradtype;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 39.h,
      ),
      child: TextFormField(
        maxLines: maxline,
        controller: controller,
        validator: validator,
        textInputAction: inputAction,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: keyboradtype,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(vertical: 14.h, horizontal: 20.w),
          fillColor: const Color(0xffF3F4F6),
          filled: true,
          suffixIcon: Icon(
            suficIcon,
            color: const Color(0xff999B9C),
          ),
          prefixIcon: prefixIcon != null
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CountryCodePicker(
                      onChanged: print,
                      initialSelection: 'IN',
                      showFlag: false,
                      showFlagDialog: true,
                      favorite: const ['+91', 'IN'],
                      onInit: (value) {
                        debugPrint(value!.dialCode);
                      },
                    ),
                    Container(
                      height: 30.h,
                      width: 1.w,
                      color: Colors.black.withOpacity(.5),
                    ),
                    SizedBox(
                      width: 10.w,
                    )
                  ],
                )
              : null,
          labelText: labeltxt,
          hintText: labeltxt,
          hintStyle: const TextStyle(color: Color(0xff999B9C), fontSize: 14),
          labelStyle: const TextStyle(color: Color(0xff999B9C), fontSize: 14),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(35.r),
          ),
        ),
      ),
    );
  }
}
