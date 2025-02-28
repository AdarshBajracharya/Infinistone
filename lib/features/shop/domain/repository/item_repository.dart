import 'package:dartz/dartz.dart';
import 'package:infinistone/core/error/failure.dart';
import 'package:infinistone/features/shop/domain/entity/item_entity.dart';

abstract interface class IItemRepository {
  Future<Either<Failure, List<ItemEntity>>> getItems();
  Future<Either<Failure, void>> createItem(ItemEntity item);
  Future<Either<Failure, void>> deleteItem(String id, String? token);
}
