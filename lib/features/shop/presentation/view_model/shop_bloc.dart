import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:infinistone/features/shop/domain/entity/item_entity.dart';
import 'package:infinistone/features/shop/domain/use_case/create_item_usecase.dart';
import 'package:infinistone/features/shop/domain/use_case/delete_item_usecase.dart';
import 'package:infinistone/features/shop/domain/use_case/get_all_item_usecase.dart';

part 'shop_event.dart';
part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  final CreateItemUseCase _createItemUseCase;
  final GetAllItemUseCase _getAllItemUseCase;
  final DeleteItemUsecase _deleteItemUsecase;

  ShopBloc({
    required CreateItemUseCase createItemUseCase,
    required GetAllItemUseCase getAllItemUseCase,
    required DeleteItemUsecase deleteItemUsecase,
  })  : _createItemUseCase = createItemUseCase,
        _getAllItemUseCase = getAllItemUseCase,
        _deleteItemUsecase = deleteItemUsecase,
        super(ShopState.initial()) {
    on<LoadItems>(_onLoadItems);
    on<AddItem>(_onAddItem);
    on<DeleteItem>(_onDeleteItem);

    // Call this event whenever the bloc is created to load the items
    add(LoadItems());
  }

  Future<void> _onLoadItems(LoadItems event, Emitter<ShopState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getAllItemUseCase.call();
    print('Result: $result');
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (items) => emit(state.copyWith(isLoading: false, items: items)),
    );
  }

  Future<void> _onAddItem(AddItem event, Emitter<ShopState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _createItemUseCase.call(CreateItemParams(
        itemName: event.itemName,
        itemPrice: event.itemPrice.toDouble(),
        itemInfo: event.itemInfo,
        itemType: event.itemType));
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (items) {
        emit(state.copyWith(isLoading: false, error: null));
        add(LoadItems());
      },
    );
  }

  Future<void> _onDeleteItem(DeleteItem event, Emitter<ShopState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result =
        await _deleteItemUsecase.call(DeleteItemParams(itemId: event.itemId));
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (batches) {
        emit(state.copyWith(isLoading: false, error: null));
        add(LoadItems());
      },
    );
  }
}
