import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';

import '../service/auth_service_provider.dart';
import 'auth_state.dart';
import '../auth_screen.dart';
import '../../layout/layout_screen.dart';
import '../../../configs/global/context.dart';
import '../../../res/components/app_snackbar.dart';

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() => const AuthState();

  // ---------------------------------------------------------------------------
  // Form Validation (synchronous — called on every keystroke)
  // ---------------------------------------------------------------------------

  void validateEmail(String value) {
    final isValid =
        value.isNotEmpty &&
        RegExp(r'^[\w\.\+\-]+@[\w\-]+\.[a-zA-Z]{2,}$').hasMatch(value);
    state = state.copyWith(isEmailValid: isValid);
  }

  void validateUsername(String value) {
    state = state.copyWith(isUsernameValid: value.trim().length >= 3);
  }

  void validateBirthday(String value) {
    final isValid = value.length == 10 && _isCalendarDateValid(value);
    state = state.copyWith(isBirthdayValid: isValid);
  }

  void validatePassword(String value) {
    final isValid =
        value.length >= 8 &&
        RegExp(r'[a-zA-Z]').hasMatch(value) &&
        RegExp(r'[0-9]').hasMatch(value) &&
        RegExp(
          r'[!@#\$%\^&\*\(\)_\+\-=\[\]\{\};:",\.<>\?/\\|`~]',
        ).hasMatch(value);
    state = state.copyWith(isPasswordValid: isValid);
  }

  void togglePasswordVisibility() {
    state = state.copyWith(obscurePassword: !state.obscurePassword);
  }

  // ---------------------------------------------------------------------------
  // Auth Operations (async)
  // ---------------------------------------------------------------------------

  /// Smart auth flow:
  /// 1. Try sign in — if user exists and password matches → navigate to layout.
  /// 2. If user not found → register a new account + write Firestore doc → navigate.
  /// 3. All other errors → show error snackbar.
  Future<void> authenticate({
    required String email,
    required String password,
    required String username,
    required String birthday,
  }) async {
    state = state.copyWith(isLoading: true);
    EasyLoading.show(status: 'Please wait...');

    try {
      await ref.read(authServiceProvider).signIn(email, password);
      _navigateToLayout();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'invalid-credential') {
        await _register(
          email: email,
          password: password,
          username: username,
          birthday: birthday,
        );
      } else if (e.code == 'wrong-password') {
        AppSnackbar.show('Incorrect password. Please try again.');
      } else {
        AppSnackbar.show(_mapFirebaseError(e.code));
      }
    } catch (_) {
      AppSnackbar.show('Something went wrong. Please try again.');
    } finally {
      EasyLoading.dismiss();
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> _register({
    required String email,
    required String password,
    required String username,
    required String birthday,
  }) async {
    try {
      await ref
          .read(authServiceProvider)
          .register(email, password, username, birthday);
      _navigateToLayout();
    } on FirebaseAuthException catch (e) {
      AppSnackbar.show(_mapFirebaseError(e.code));
    } catch (_) {
      AppSnackbar.show('Something went wrong. Please try again.');
    }
  }

  /// Signs out and returns to the auth screen.
  Future<void> signOut() async {
    try {
      await ref.read(authServiceProvider).signOut();
      AppContext.navigatorKey.currentContext?.goNamed(AuthScreen.routeName);
    } catch (_) {
      AppSnackbar.show('Sign out failed. Please try again.');
    }
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  void _navigateToLayout() {
    AppContext.navigatorKey.currentContext?.goNamed(LayoutScreen.routeName);
  }

  String _mapFirebaseError(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'An account with this email already exists.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'weak-password':
        return 'Password is too weak. Try a stronger one.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'too-many-requests':
        return 'Too many attempts. Please wait and try again.';
      case 'network-request-failed':
        return 'No internet connection. Please check your network.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }

  bool _isCalendarDateValid(String ddmmyyyy) {
    // Format guaranteed by AuthDateFormatter: DD/MM/YYYY
    final parts = ddmmyyyy.split('/');
    if (parts.length != 3) return false;
    final day = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final year = int.tryParse(parts[2]);
    if (day == null || month == null || year == null) return false;
    return day >= 1 && day <= 31 && month >= 1 && month <= 12 && year >= 1900;
  }
}
