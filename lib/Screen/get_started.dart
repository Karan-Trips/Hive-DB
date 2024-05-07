// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:task_27_03/pages/loginscreens/mobile_login.dart';

import '../Model/storeClass/store.dart';
import '../Model/widetsClass/elevatedbutton/elevated_button_class.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  int currentIndex = 0;

  late PageController controller = controller = PageController(initialPage: 0);

  @override
  void initState() {
    redirectCheck();
    controller = PageController();
    super.initState();
  }

  Future redirectCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('phoneno');

    await Future.delayed(const Duration(seconds: 0));

    if (token != null && token.isNotEmpty) {
      Navigator.pushReplacementNamed(context, '/mainscreen');
    } else {
      Navigator.pushReplacementNamed(context, '/mobilelogin');
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Locale _currentLocale = Locale('hi');

  void changeLanguageToEnglish() {
    setState(() {
      _currentLocale = Locale('en');
    });
  }

  void changeLanguageToHindi() {
    setState(() {
      _currentLocale = Locale('hi');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: const [Locale('en'), Locale('hi')],
      locale: _currentLocale,
      home: Scaffold(
        body: Scaffold(
          body: Stack(children: [
            PageView.builder(
                itemCount: datas.length,
                controller: controller,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (_, i) {
                  return Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: 300,
                            child: Lottie.asset(datas[i].image,
                                fit: BoxFit.contain)),
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          datas[i].title,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.5)),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  );
                }),
            Positioned(
              top: 45,
              right: 25,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        if (currentIndex != datas.length - 1) {
                          // showDialog(
                          //   context: context,
                          //   builder: (context) {
                          //     return AlertDialog(
                          //       content: Text("Select the language"),
                          //       actions: [
                          //         TextButton(
                          //           onPressed: changeLanguageToEnglish,
                          //           child: Text('English'),
                          //         ),
                          //         TextButton(
                          //           onPressed: changeLanguageToHindi,
                          //           child: Text('Hindi'),
                          //         ),
                          //       ],
                          //     );
                          //   },
                          // );
                          Navigator.pushNamedAndRemoveUntil(
                              context, "/mobilelogin", (route) => false);
                        }
                      },
                      child: Text(
                        currentIndex == datas.length - 1 ? '' : 'Skip',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    )),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 20,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmoothPageIndicator(
                        controller: controller,
                        count: datas.length,
                        effect: ExpandingDotsEffect(
                            dotHeight: 8,
                            spacing: 4,
                            dotWidth: 10,
                            activeDotColor: Colors.green),
                        onDotClicked: (index) {
                          controller.animateToPage(index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOutCirc);
                        }),
                    Elevatedbutton(
                        onPressed: () {
                          if (currentIndex == datas.length - 1) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MobileLogin()));
                          } else {
                            controller.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOutCirc);
                          }
                        },
                        currentIndex: currentIndex,
                        controller: controller,
                        txt: currentIndex == datas.length - 1 ? 'Go' : 'Next'),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
