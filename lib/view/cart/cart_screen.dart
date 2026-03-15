import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'widgets/cart_body.dart';
import '../../configs/themes/colors.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  static const routePath = '/cart';
  static const routeName = 'cart';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(backgroundColor: AppColors.white, body: CartBody());
  }
}
