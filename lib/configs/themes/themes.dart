import 'package:flutter/material.dart';

import './styles.dart';
import './colors.dart';

class AppThemes {
  static late BuildContext context;

  ThemeData lightTheme() {
    final mediaQuery = MediaQuery.of(context);
    final safeAreaHeight = mediaQuery.size.height - mediaQuery.padding.top;
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      textTheme: AppStyles.styles,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        iconTheme: IconThemeData(color: AppColors.white),
        titleTextStyle: AppStyles.styles.titleMedium?.copyWith(
          color: Colors.white,
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        insetPadding: const EdgeInsets.all(24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        showDragHandle: true,
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        dragHandleSize: const Size(64, 6),
        dragHandleColor: AppColors.greyLight,
        constraints: BoxConstraints(maxHeight: safeAreaHeight),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.main,
          surfaceTintColor: AppColors.main,
          padding: const EdgeInsets.all(16),
          disabledBackgroundColor: AppColors.greyLight,
          overlayColor: AppColors.white.withValues(alpha: 0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.main,
        selectionHandleColor: AppColors.main,
        selectionColor: AppColors.main.withValues(alpha: 0.2),
      ),
    );
  }

  ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      textTheme: AppStyles.styles,
      brightness: Brightness.dark,
    );
  }
}
