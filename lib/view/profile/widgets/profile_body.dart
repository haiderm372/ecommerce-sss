import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'profile_details_card.dart';
import 'profile_sign_out_button.dart';
import '../../../res/models/user_model.dart';
import '../../../configs/themes/colors.dart';

class ProfileBody extends ConsumerWidget {
  const ProfileBody({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ── Avatar ────────────────────────────────────────────────────
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.mainLight, AppColors.main],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.main.withValues(alpha: 0.25),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  user.username.isNotEmpty
                      ? user.username[0].toUpperCase()
                      : '?',
                  style: textTheme.headlineLarge?.copyWith(
                    color: AppColors.white,
                    fontSize: 36,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ── Name ──────────────────────────────────────────────────────
            Text(
              user.username,
              style: textTheme.headlineMedium?.copyWith(
                color: AppColors.black,
                fontSize: 22,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              user.email,
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.grey,
                letterSpacing: 0.3,
              ),
            ),

            const SizedBox(height: 36),

            // ── Details card ──────────────────────────────────────────────
            ProfileDetailsCard(user: user),

            const SizedBox(height: 28),

            // ── Sign out ──────────────────────────────────────────────────
            const ProfileSignOutButton(),
          ],
        ),
      ),
    );
  }
}
