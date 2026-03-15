import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../cart/cart_screen.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';
import './widgets/layout_icon_chip.dart';
import '../../configs/themes/colors.dart';
import '../../configs/assets/icons/icons.dart';
import '../profile/provider/profile_provider.dart';
import '../cart/provider/cart_weather_provider.dart';

class LayoutScreen extends ConsumerStatefulWidget {
  const LayoutScreen({super.key});

  static const routePath = '/layout';
  static const routeName = 'layout';

  @override
  ConsumerState<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends ConsumerState<LayoutScreen> {
  final ValueNotifier<int> _screenIndex = ValueNotifier(0);
  final List<Widget> _screenLists = <Widget>[
    HomeScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    ref.read(userProfileProvider.future).ignore();
    ref.read(cartWeatherProvider.future).ignore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<int>(
        valueListenable: _screenIndex,
        builder: (ctx, i, _) {
          return _screenLists.elementAt(i);
        },
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0x18000000),
              offset: Offset(0, -1),
              blurRadius: 33,
              spreadRadius: 0,
            ),
          ],
        ),
        child: ValueListenableBuilder(
          valueListenable: _screenIndex,
          builder: (ctx, i, _) {
            return Row(
              children: [
                Expanded(
                  child: LayoutIconChip(
                    title: "Shop",
                    icon: AppIcons.shop,
                    isEnable: i == 0,
                    onTap: () {
                      _screenIndex.value = 0;
                    },
                  ),
                ),
                Expanded(
                  child: LayoutIconChip(
                    title: "Cart",
                    icon: AppIcons.cart,
                    isEnable: i == 1,
                    onTap: () {
                      _screenIndex.value = 1;
                    },
                  ),
                ),
                Expanded(
                  child: LayoutIconChip(
                    title: "Person",
                    icon: AppIcons.person,
                    isEnable: i == 2,
                    onTap: () {
                      _screenIndex.value = 2;
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
