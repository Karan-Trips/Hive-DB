import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:onboarding_animation/onboarding_animation.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoardingAnimation(
        pages: [
          Lottie.asset("assets/json/shoppingcart.json"),
          Lottie.asset("assets/json/payment3.json"),
          Lottie.asset("assets/json/care.json"),
        ],
        indicatorDotHeight: 7.0,
        indicatorDotWidth: 7.0,
        indicatorFixedCenter: false,
        
        indicatorType: IndicatorType.expandingDots,
        indicatorPosition: IndicatorPosition.bottomCenter,
      ),
    );
  }
}
