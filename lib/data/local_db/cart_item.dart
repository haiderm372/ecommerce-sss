import 'package:isar/isar.dart';

part 'cart_item.g.dart';

@collection
class CartItem {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String title;

  late String image;
  late String description;
  late int count;
}
