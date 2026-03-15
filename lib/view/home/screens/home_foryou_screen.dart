import 'dart:ui';
import 'package:ecommerce/configs/assets/images/images.dart';
import 'package:flutter/material.dart';

import '../widgets/home_foryou_cards.dart';
import '../widgets/home_gradient_text.dart';
import '../../../configs/themes/colors.dart';

class HomeForyouScreen extends StatelessWidget {
  const HomeForyouScreen({super.key, this.scrollController});

  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      controller: scrollController,
      padding: EdgeInsets.all(16),
      child: Column(
        spacing: 16,
        crossAxisAlignment: .start,
        children: [
          AspectRatio(
            aspectRatio: 0.9,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xffFF9595),
                borderRadius: BorderRadius.circular(30),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Padding(
                  padding: const EdgeInsets.only(top: 50, left: 50),
                  child: Image.asset(
                    fit: BoxFit.fitHeight,
                    AppImages.blackPersonNb,
                  ),
                ),
              ),
            ),
          ),

          HomeGradientText(
            title: 'Emerging Designers',
            subTitle:
                'Explore small businesses and discover unique, one-of-a-kind looks.',
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 34, vertical: 12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [0.9884, 1.0],
                colors: [Color(0xFF001226), Color(0xFF3C3C3C)],
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x73626262),
                  offset: Offset(0, 8),
                  blurRadius: 8,
                ),
                BoxShadow(
                  color: Color(0x40000000),
                  offset: Offset(0, 4),
                  blurRadius: 4,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                child: Row(
                  spacing: 20,
                  mainAxisSize: .min,
                  children: [
                    Text(
                      'Shop',
                      style: textTheme.titleLarge?.copyWith(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    Icon(Icons.arrow_forward, color: AppColors.white),
                  ],
                ),
              ),
            ),
          ),

          HomeForyouCards(),
        ],
      ),
    );
  }
}
