import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:infinistone/app/shared_prefs/token_shared_prefs.dart';
import 'package:infinistone/app/usecase/usecase.dart';
import 'package:infinistone/core/error/failure.dart';
import 'package:infinistone/features/shop/domain/repository/item_repository.dart';

class DeleteItemParams extends Equatable {
  final String itemId;

  const DeleteItemParams({required this.itemId});

  const DeleteItemParams.empty() : itemId = '_empty.string';

  @override
  List<Object?> get props => [
        itemId,
      ];
}

class DeleteItemUsecase implements UsecaseWithParams<void, DeleteItemParams> {
  final IItemRepository itemRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  DeleteItemUsecase({
    required this.itemRepository,
    required this.tokenSharedPrefs,
  });

  @override
  Future<Either<Failure, void>> call(DeleteItemParams params) async {
    // Get token from Shared Preferences and send it to the server
    final token = await tokenSharedPrefs.getToken();
    return token.fold((l) {
      return Left(l);
    }, (r) async {
      return await itemRepository.deleteItem(params.itemId, r);
    });
  }
}
