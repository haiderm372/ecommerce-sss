import 'package:flutter/material.dart';

class HomeGradientText extends StatelessWidget {
  const HomeGradientText({
    super.key,
    required this.title,
    required this.subTitle,
  });
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        stops: [0.18, 0.46, 0.615],
        colors: [
          Color.fromRGBO(33, 33, 33, 0.79),
          Color.fromRGBO(135, 135, 135, 0.79),
          Color.fromRGBO(0, 0, 0, 0.79),
        ],
      ).createShader(bounds),
      blendMode: BlendMode.srcIn,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$title\n',
              style: textTheme.titleLarge?.copyWith(
                fontSize: 33,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
            TextSpan(
              text: subTitle,
              style: textTheme.labelLarge?.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
