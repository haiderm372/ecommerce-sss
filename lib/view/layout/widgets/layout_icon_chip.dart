import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../configs/themes/colors.dart';

class LayoutIconChip extends StatelessWidget {
  const LayoutIconChip({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    required this.isEnable,
  });

  final String title;
  final String icon;
  final bool isEnable;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    Gradient iconGradient = isEnable
        ? const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            transform: GradientRotation(134.57 * 3.14159 / 180),
            colors: [Color(0xFF5AB0FF), Color(0xFF0079FF)],
            stops: [-0.0076, 1.0],
          )
        : const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            transform: GradientRotation(134.57 * 3.14159 / 180),
            colors: [Color(0xFFF1F1F1), Color(0xFF797979)],
            stops: [-0.0076, 1.0],
          );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        overlayColor: WidgetStatePropertyAll(
          AppColors.main.withValues(alpha: 0.1),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            spacing: 6,
            mainAxisSize: .min,
            crossAxisAlignment: .center,
            mainAxisAlignment: .center,
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: ShaderMask(
                  shaderCallback: (bounds) {
                    return iconGradient.createShader(bounds);
                  },
                  blendMode: BlendMode.srcIn,
                  child: SvgPicture.asset(icon),
                ),
              ),
              Text(
                title,
                style: textTheme.labelLarge?.copyWith(
                  fontSize: 10,
                  color: isEnable ? AppColors.main : Color(0xffC1CEDC),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
