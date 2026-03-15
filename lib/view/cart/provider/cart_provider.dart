import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/local_db/cart_item.dart';
import '../../../data/local_db/local_db_service.dart';

// Stream of all cart items — auto-updates when DB changes
final cartItemsProvider = StreamProvider<List<CartItem>>((ref) {
  return LocalDbService.watchCartItems();
});

// Convenience: map of title -> count for quick badge lookups
final cartCountMapProvider = Provider<Map<String, int>>((ref) {
  final cartAsync = ref.watch(cartItemsProvider);
  return cartAsync.maybeWhen(
    data: (items) => {for (final item in items) item.title: item.count},
    orElse: () => {},
  );
});
