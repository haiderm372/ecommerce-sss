import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'cart_item.dart';

class LocalDbService {
  static Isar? _isar;

  static Future<Isar> get isar async {
    if (_isar != null) return _isar!;
    final dir = await getApplicationSupportDirectory();
    _isar = await Isar.open([CartItemSchema], directory: dir.path);
    return _isar!;
  }

  // Add or increment a cart item
  static Future<void> addToCart({
    required String title,
    required String image,
    required String description,
  }) async {
    final db = await isar;
    await db.writeTxn(() async {
      final existing = await db.cartItems
          .where()
          .titleEqualTo(title)
          .findFirst();
      if (existing != null) {
        existing.count += 1;
        await db.cartItems.put(existing);
      } else {
        final item = CartItem()
          ..title = title
          ..image = image
          ..description = description
          ..count = 1;
        await db.cartItems.put(item);
      }
    });
  }

  // Remove or decrement a cart item
  static Future<void> removeFromCart(String title) async {
    final db = await isar;
    await db.writeTxn(() async {
      final existing = await db.cartItems
          .where()
          .titleEqualTo(title)
          .findFirst();
      if (existing == null) return;
      if (existing.count > 1) {
        existing.count -= 1;
        await db.cartItems.put(existing);
      } else {
        await db.cartItems.delete(existing.id);
      }
    });
  }

  // Watch all cart items (reactive stream)
  static Stream<List<CartItem>> watchCartItems() async* {
    final db = await isar;
    yield* db.cartItems.where().watch(fireImmediately: true);
  }

  // Get count for a specific item
  static Future<int> getItemCount(String title) async {
    final db = await isar;
    final item = await db.cartItems.where().titleEqualTo(title).findFirst();
    return item?.count ?? 0;
  }
}
