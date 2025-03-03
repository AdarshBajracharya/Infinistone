import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinistone/features/home/domain/use_case/create_bookings_usecase.dart';
import 'package:infinistone/features/home/presentation/view_model/bookings_bloc.dart';
import 'package:infinistone/features/shop/domain/entity/item_entity.dart';
import 'package:infinistone/features/shop/domain/use_case/create_item_usecase.dart';
import 'package:infinistone/features/shop/domain/use_case/delete_item_usecase.dart';
import 'package:infinistone/features/shop/domain/use_case/get_all_item_usecase.dart';

part 'shop_event.dart';
part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  final BookingsBloc _bookingBloc;
  final CreateItemUseCase _createItemUseCase;
  final GetAllItemUseCase _getAllItemUseCase;
  final DeleteItemUsecase _deleteItemUsecase;
  final CreateBookingUseCase _createBookingUseCase;

  ShopBloc({
    required CreateItemUseCase createItemUseCase,
    required GetAllItemUseCase getAllItemUseCase,
    required DeleteItemUsecase deleteItemUsecase,
    required CreateBookingUseCase createBookingUseCase,
    required BookingsBloc bookingsBloc,
  })  : _createItemUseCase = createItemUseCase,
        _getAllItemUseCase = getAllItemUseCase,
        _deleteItemUsecase = deleteItemUsecase,
        _createBookingUseCase = createBookingUseCase,
        _bookingBloc = bookingsBloc,
        super(ShopState.initial()) {
    on<LoadItems>(_onLoadItems);
    on<AddItem>(_onAddItem);
    on<DeleteItem>(_onDeleteItem);
    on<AddBooking>(_onAddBooking);
    on<NavigatetoItem>((event, emit) {
      Navigator.push(
          event.context,
          MaterialPageRoute(
              builder: (context) => MultiBlocProvider(providers: [
                    BlocProvider.value(value: _bookingBloc),
                  ], child: event.destination)));
    });

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

  Future<void> _onAddBooking(AddBooking event, Emitter<ShopState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _createBookingUseCase.call(CreateBookingParams(
      customerId: event.customerId,
      productId: event.productId,
      bookingDate: event.bookingDate,
    ));
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (bookings) {
        emit(state.copyWith(isLoading: false, error: null));
        add(LoadBookings());
      },
    );
  }
}
