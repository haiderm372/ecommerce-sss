import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../global/context.dart';
import '../../view/auth/auth_screen.dart';
import '../../view/cart/cart_screen.dart';
import '../../view/home/home_screen.dart';
import '../../view/layout/layout_screen.dart';
import '../../view/profile/profile_screen.dart';

class AppRoutes {
  static final GoRouter routes = GoRouter(
    navigatorKey: AppContext.navigatorKey,
    initialLocation: AuthScreen.routePath,
    redirect: (context, state) {
      final isLoggedIn = FirebaseAuth.instance.currentUser != null;
      final isGoingToAuth = state.matchedLocation == AuthScreen.routePath;
      if (isLoggedIn && isGoingToAuth) return LayoutScreen.routePath;
      return null;
    },
    routes: [
      GoRoute(
        path: AuthScreen.routePath,
        name: AuthScreen.routeName,
        builder: (context, state) => AuthScreen(),
      ),
      GoRoute(
        path: LayoutScreen.routePath,
        name: LayoutScreen.routeName,
        builder: (context, state) => LayoutScreen(),
      ),
      GoRoute(
        path: HomeScreen.routePath,
        name: HomeScreen.routeName,
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: CartScreen.routePath,
        name: CartScreen.routeName,
        builder: (context, state) => CartScreen(),
      ),
      GoRoute(
        path: ProfileScreen.routePath,
        name: ProfileScreen.routeName,
        builder: (context, state) => ProfileScreen(),
      ),
    ],
  );
}
