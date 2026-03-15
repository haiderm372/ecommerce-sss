import 'package:flutter/material.dart';

class AppContext {
  /// Global navigator key (router-level)
  static final navigatorKey = GlobalKey<NavigatorState>();

  /// Global scaffold messenger key
  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  /// Global context (works with MaterialApp.router)
  static BuildContext get context {
    final ctx = navigatorKey.currentState?.overlay?.context;
    if (ctx == null) {
      throw FlutterError(
        'AppContext is not ready. '
        'Make sure navigatorKey is attached to the router.',
      );
    }
    return ctx;
  }

  /// Navigator state (for push/pop)
  static NavigatorState get navigatorState {
    final nav = navigatorKey.currentState;
    if (nav == null) {
      throw FlutterError(
        'NavigatorState is not attached. '
        'Check router navigatorKey.',
      );
    }
    return nav;
  }

  /// Scaffold messenger state (snackbars)
  static ScaffoldMessengerState get messengerState {
    final messenger = scaffoldMessengerKey.currentState;
    if (messenger == null) {
      throw FlutterError('ScaffoldMessengerState is not attached.');
    }
    return messenger;
  }
}
