part of 'shop_bloc.dart';

class ShopState extends Equatable {
  final List<ItemEntity> items;
  final bool isLoading;
  final String? error;

  const ShopState({
    required this.items,
    required this.isLoading,
    this.error,
  });

  factory ShopState.initial() {
    return const ShopState(
      items: [],
      isLoading: false,
    );
  }

  ShopState copyWith({
    List<ItemEntity>? items,
    bool? isLoading,
    String? error,
  }) {
    return ShopState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [items, isLoading, error];
}
