import 'package:dartz/dartz.dart';
import 'package:infinistone/app/usecase/usecase.dart';
import 'package:infinistone/core/error/failure.dart';
import 'package:infinistone/features/shop/domain/entity/item_entity.dart';
import 'package:infinistone/features/shop/domain/repository/item_repository.dart';

class GetAllItemUseCase implements UsecaseWithoutParams<List<ItemEntity>> {
  final IItemRepository itemRepository;

  GetAllItemUseCase({required this.itemRepository});

  @override
  Future<Either<Failure, List<ItemEntity>>> call() {
    print('GetAllItemUseCase called');
    return itemRepository.getItems();
  }
}
