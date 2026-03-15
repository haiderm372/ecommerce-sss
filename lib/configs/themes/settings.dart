import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AppSettings {
  void configureEasyLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 42
      ..radius = 20
      ..maskType = EasyLoadingMaskType.custom
      ..maskColor = Colors.white.withValues(alpha: 0.4)
      ..backgroundColor = const Color(0xFFF5f5f5)
      ..indicatorColor = const Color(0xFF0079FF)
      ..textColor = Colors.white
      ..textStyle = const TextStyle(
        fontSize: 13,
        fontFamily: 'poppins',
        fontWeight: FontWeight.w500,
        color: Colors.black,
        letterSpacing: 0.3,
      )
      ..boxShadow = [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 24,
          offset: const Offset(0, 8),
        ),
      ]
      ..dismissOnTap = false;
  }
}
