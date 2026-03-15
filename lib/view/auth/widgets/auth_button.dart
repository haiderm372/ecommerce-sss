import 'package:flutter/material.dart';

import '../../../configs/themes/colors.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.label,
    required this.onTap,
    this.isEnabled = true,
  });

  final String label;
  final VoidCallback? onTap;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 32),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            transform: GradientRotation(134.57 * 3.14159 / 180),
            colors: isEnabled
                ? [AppColors.mainLight, AppColors.main]
                : [Color(0xFFE4E4E4), Color(0xFF808080)],
            stops: [-0.0076, 1.0],
          ),
          borderRadius: BorderRadius.circular(62),
          boxShadow: [
            BoxShadow(
              color: Color(0xA60079FF),
              offset: Offset(0, 18),
              blurRadius: 62,
              spreadRadius: -20,
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: textTheme.labelLarge?.copyWith(
              fontSize: 14,
              letterSpacing: 0.8,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
