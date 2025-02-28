part of 'shop_bloc.dart';

@immutable
sealed class ShopEvent extends Equatable {
  const ShopEvent();

  @override
  List<Object> get props => [];
}

final class LoadItems extends ShopEvent {}

class LoadImage extends ShopEvent {
  final File file;

  const LoadImage({
    required this.file,
  });
}



final class AddItem extends ShopEvent {
  final String itemName;
  final String itemType;
  final String itemInfo;
  final double itemPrice;
  final String? itemImage;

  const AddItem(this.itemName, this.itemType, this.itemInfo, this.itemPrice, this.itemImage);

  @override
  List<Object> get props => [itemName, itemType, itemInfo, itemPrice];
}

final class DeleteItem extends ShopEvent {
  final String itemId;

  const DeleteItem(this.itemId);

  @override
  List<Object> get props => [itemId];
}


