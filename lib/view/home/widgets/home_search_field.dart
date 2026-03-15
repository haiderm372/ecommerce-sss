import 'package:flutter/material.dart';

import '../../../configs/themes/colors.dart';

class HomeSearchField extends StatelessWidget {
  const HomeSearchField({super.key, this.isPinned = false});

  final bool isPinned;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: TextField(
        style: textTheme.titleMedium?.copyWith(
          fontSize: 12,
          color: AppColors.black,
        ),
        decoration: InputDecoration(
          filled: true,
          hintText: "Search your product…",
          hintStyle: textTheme.titleMedium?.copyWith(
            fontSize: 12,
            color: Color(0xffABABAB),
          ),
          suffixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Icon(Icons.sort),
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Icon(Icons.search),
          ),
          fillColor: isPinned
              ? Colors.white.withValues(alpha: 0.18)
              : AppColors.greyLight,
          constraints: BoxConstraints(),
          prefixIconConstraints: BoxConstraints(),
          suffixIconConstraints: BoxConstraints(),
          border: .none,
          errorBorder: .none,
          focusedBorder: .none,
          enabledBorder: .none,
          disabledBorder: .none,
          focusedErrorBorder: .none,
        ),
      ),
    );
  }
}
