import 'package:flutter/material.dart';

import '../../../configs/themes/colors.dart';

class AuthTextTab extends StatelessWidget {
  const AuthTextTab({
    super.key,
    required this.title,
    required this.onTap,
    required this.isEnable,
  });

  final String title;
  final bool isEnable;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          onTap.call();
        },
        overlayColor: WidgetStatePropertyAll(
          AppColors.main.withValues(alpha: 0.1),
        ),
        child: Center(
          child: Column(
            spacing: 6,
            mainAxisSize: .min,
            mainAxisAlignment: .center,
            crossAxisAlignment: .center,
            children: [
              Text(
                title,
                textAlign: .center,
                style: textTheme.headlineMedium?.copyWith(
                  color: isEnable ? AppColors.black : AppColors.grey,
                  fontSize: 13,
                ),
              ),
              if (isEnable)
                Container(
                  height: 3,
                  width: 35,
                  decoration: BoxDecoration(
                    color: AppColors.main,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
