import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Model/widetsClass/elevatedbutton/elevated_button_class.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final pinController = TextEditingController();

  final focusNode = FocusNode();

  int verificationCodeInt = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Verification Code',
          style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.all(42.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 68.h,
                child: Text(
                  textAlign: TextAlign.center,
                  "Verification code has been send on your registered mobile number. Enter Verification code here.",
                  style: TextStyle(
                      fontSize: 14.w,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              27.verticalSpace,
              OtpTextField(
                numberOfFields: 4,
                fieldHeight: 60.r,
                fieldWidth: 55.r,
                filled: true,

                hasCustomInputDecoration: true,
                decoration: InputDecoration(
                    isDense: true,
                    // contentPadding: EdgeInsets.all(16),
                    alignLabelWithHint: true,
                    filled: true,
                    fillColor: const Color(0xffF3F4F6),
                    hintText: "-",
                    counterText: "",
                    border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 0, style: BorderStyle.none),
                        borderRadius: BorderRadius.circular(50))),
                keyboardType: TextInputType.number,

                // showFieldAsBox: true,
                // borderRadius: BorderRadius.circular(50),
                onCodeChanged: (String code) {
                  debugPrint(code);
                },

                onSubmit: (String verificationCode) {
                  verificationCodeInt = int.parse(verificationCode);
                  debugPrint(verificationCode);
                },
              ),
              79.verticalSpace,
              SizedBox(
                width: double.infinity,
                height: 52,
                child: Elevatedbutton(
                  txt: 'Verify',
                  onPressed: () {
                    if (verificationCodeInt == 5555) {
                      Navigator.pushNamedAndRemoveUntil(context, '/detailpage',
                          ModalRoute.withName('/mobilelogin'));
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const AlertDialog(
                            title: Text("OTP"),
                            content: Text("Check your OTP"),
                          );
                        },
                      );
                      debugPrint('Check the code');
                    }
                  },
                ),
              ),
              40.verticalSpace,
              TextButton(
                  onPressed: () {},
                  child: Text(
                    "Resend Code",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                    ),
                  )),
              5.verticalSpace,
              Opacity(
                opacity: .4,
                child: Image.asset(
                  'assets/images/splash.png',
                  height: 200.h,
                  fit: BoxFit.cover,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
