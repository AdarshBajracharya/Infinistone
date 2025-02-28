import 'package:dartz/dartz.dart';
import 'package:infinistone/core/error/failure.dart';
import 'package:infinistone/features/shop/data/data_source/remote_data_source/item_remote_datasource.dart';
import 'package:infinistone/features/shop/domain/entity/item_entity.dart';
import 'package:infinistone/features/shop/domain/repository/item_repository.dart';

class ItemRemoteRepository implements IItemRepository {
  final ItemRemoteDataSource remoteDataSource;

  ItemRemoteRepository({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> createItem(ItemEntity item) async {
    try {
      remoteDataSource.createItem(item);
      return Right(null);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteItem(String id, String? token) async {
    try {
      remoteDataSource.deleteItem(id, token);
      return Right(null);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<ItemEntity>>> getItems() async {
    try {
      final items = await remoteDataSource.getItems();
      return Right(items);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }
}
