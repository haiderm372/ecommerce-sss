import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../res/models/for_you_model.dart';
import '../../cart/provider/cart_provider.dart';
import '../../home/widgets/home_foryou_cards.dart';
import 'cart_weather_card.dart';

class CartBody extends ConsumerWidget {
  const CartBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartAsync = ref.watch(cartItemsProvider);
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            const CartWeatherCard(),

            cartAsync.when(
              loading: () => const SizedBox.shrink(),
              error: (_, _) => const SizedBox.shrink(),
              data: (cartItems) {
                if (cartItems.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Column(
                        spacing: 8,
                        children: [
                          Icon(
                            Icons.shopping_bag_outlined,
                            size: 56,
                            color: Colors.black26,
                          ),
                          Text(
                            'Your cart is empty',
                            style: textTheme.bodyMedium?.copyWith(
                              color: Colors.black45,
                            ),
                          ),
                          Text(
                            'Tap any item on the home screen to add it.',
                            style: textTheme.bodySmall?.copyWith(
                              color: Colors.black38,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                // Convert CartItem -> ForYouModel for the shared widget
                final forYouItems = cartItems
                    .map(
                      (e) => ForYouModel(
                        image: e.image,
                        title: e.title,
                        description: e.description,
                      ),
                    )
                    .toList();

                return HomeForyouCards(items: forYouItems, isCartMode: true);
              },
            ),
          ],
        ),
      ),
    );
  }
}
