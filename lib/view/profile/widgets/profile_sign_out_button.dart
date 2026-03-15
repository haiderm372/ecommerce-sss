import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../configs/themes/colors.dart';
import '../../../res/components/app_snackbar.dart';
import '../../auth/provider/auth_provider.dart';

class ProfileSignOutButton extends ConsumerStatefulWidget {
  const ProfileSignOutButton({super.key});

  @override
  ConsumerState<ProfileSignOutButton> createState() =>
      _ProfileSignOutButtonState();
}

class _ProfileSignOutButtonState extends ConsumerState<ProfileSignOutButton> {
  bool _loading = false;

  Future<void> _signOut() async {
    setState(() => _loading = true);
    try {
      await ref.read(authProvider.notifier).signOut();
    } catch (_) {
      AppSnackbar.show('Sign out failed. Please try again.');
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: _loading ? null : _signOut,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: AppColors.red.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(62),
          border: Border.all(color: AppColors.red.withValues(alpha: 0.15)),
        ),
        child: Center(
          child: _loading
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    color: AppColors.red,
                    strokeWidth: 2,
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.logout_rounded,
                      color: AppColors.red,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Sign Out',
                      style: textTheme.labelSmall?.copyWith(
                        color: AppColors.red,
                        fontSize: 14,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
