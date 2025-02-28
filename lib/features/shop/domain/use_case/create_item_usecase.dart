import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:infinistone/app/usecase/usecase.dart';
import 'package:infinistone/core/error/failure.dart';
import 'package:infinistone/features/shop/domain/entity/item_entity.dart';
import 'package:infinistone/features/shop/domain/repository/item_repository.dart';

class CreateItemParams extends Equatable {
  final String itemName;
  final String itemType;
  final String itemInfo;
  final double itemPrice;
  final String? itemImage;

  const CreateItemParams(
      {required this.itemName,
      required this.itemType,
      required this.itemInfo,
      required this.itemPrice,
      this.itemImage});

  // Empty constructor
  const CreateItemParams.empty()
      : itemName = '_empty.string',
        itemType = '_empty.string',
        itemInfo = '_empty.string',
        itemPrice = 0,
        itemImage = '_empty.string';

  @override
  List<Object?> get props => [itemName];
}

class CreateItemUseCase implements UsecaseWithParams<void, CreateItemParams> {
  final IItemRepository itemRepository;

  CreateItemUseCase({required this.itemRepository});

  @override
  Future<Either<Failure, void>> call(CreateItemParams params) async {
    return await itemRepository.createItem(
      ItemEntity(
        itemName: params.itemName,
        itemType: params.itemType,
        itemInfo: params.itemInfo,
        itemPrice: params.itemPrice,
        itemImage: params.itemImage,
      ),
    );
  }
}
