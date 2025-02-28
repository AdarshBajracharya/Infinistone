
import 'package:infinistone/features/shop/domain/entity/item_entity.dart';

abstract interface class IItemDataSource {
  Future<List<ItemEntity>> getItems();
  Future<void> createItem(ItemEntity item);
  Future<void> deleteItem(String id, String? token);
}
