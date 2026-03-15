import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../configs/themes/colors.dart';
import 'provider/profile_provider.dart';
import 'widgets/profile_body.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  static const routePath = '/profile';
  static const routeName = 'profile';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(userProfileProvider);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: profileAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(
            color: AppColors.main,
            strokeWidth: 2,
          ),
        ),
        error: (_, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline_rounded,
                color: AppColors.red,
                size: 40,
              ),
              const SizedBox(height: 12),
              Text(
                'Failed to load profile',
                style: textTheme.bodyMedium?.copyWith(color: AppColors.grey),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => ref.invalidate(userProfileProvider),
                child: Text(
                  'Retry',
                  style: textTheme.labelSmall?.copyWith(color: AppColors.main),
                ),
              ),
            ],
          ),
        ),
        data: (user) => ProfileBody(user: user),
      ),
    );
  }
}
