import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../data/home_data.dart';
import '../../../res/models/for_you_model.dart';
import '../../cart/provider/cart_provider.dart';
import '../../../data/local_db/local_db_service.dart';

class HomeForyouCards extends ConsumerWidget {
  // When used in cart, pass items explicitly and hide the add badge
  final List<ForYouModel>? items;
  final bool isCartMode;

  const HomeForyouCards({super.key, this.items, this.isCartMode = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final listing = items ?? HomeData.foryouListing;
    final countMap = ref.watch(cartCountMapProvider);

    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isCartMode ? 'Cart Items:' : 'For You:',
          style: textTheme.labelLarge?.copyWith(
            fontSize: 18,
            color: Colors.black,
          ),
        ),

        MasonryGridView.count(
          itemCount: listing.length,
          shrinkWrap: true,
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final item = listing[index];
            final count = countMap[item.title] ?? 0;

            return GestureDetector(
              onTap: isCartMode
                  ? null
                  : () => LocalDbService.addToCart(
                      title: item.title,
                      image: item.image,
                      description: item.description,
                    ),
              child: AspectRatio(
                aspectRatio: index % 2 == 0 ? 1.0 : 0.49,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xffFF9595),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(fit: BoxFit.cover, item.image),

                        // Gradient + text overlay at bottom
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black.withValues(alpha: 0.7),
                                  Colors.transparent,
                                ],
                              ),
                              borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(30),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  item.title,
                                  style: textTheme.labelLarge?.copyWith(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  item.description,
                                  style: textTheme.bodySmall?.copyWith(
                                    fontSize: 10,
                                    color: Colors.white70,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Count badge (top-right) — shown when count > 0
                        if (count > 0)
                          Positioned(
                            top: 10,
                            right: 10,
                            child: _CountBadge(
                              count: count,
                              isCartMode: isCartMode,
                              onRemove: isCartMode
                                  ? () => LocalDbService.removeFromCart(
                                      item.title,
                                    )
                                  : null,
                              onAdd: isCartMode
                                  ? () => LocalDbService.addToCart(
                                      title: item.title,
                                      image: item.image,
                                      description: item.description,
                                    )
                                  : null,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _CountBadge extends StatelessWidget {
  final int count;
  final bool isCartMode;
  final VoidCallback? onRemove;
  final VoidCallback? onAdd;

  const _CountBadge({
    required this.count,
    required this.isCartMode,
    this.onRemove,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    if (isCartMode) {
      // Cart mode: show - count + controls
      return Container(
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: onRemove,
              child: const Icon(Icons.remove, color: Colors.white, size: 14),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                '$count',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GestureDetector(
              onTap: onAdd,
              child: const Icon(Icons.add, color: Colors.white, size: 14),
            ),
          ],
        ),
      );
    }

    // Home mode: simple count pill
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '$count',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
