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

  const AddItem(this.itemName, this.itemType, this.itemInfo, this.itemPrice,
      this.itemImage);

  @override
  List<Object> get props => [itemName, itemType, itemInfo, itemPrice];
}

final class DeleteItem extends ShopEvent {
  final String itemId;

  const DeleteItem(this.itemId);

  @override
  List<Object> get props => [itemId];
}

final class LoadBookings extends ShopEvent {}

final class AddBooking extends ShopEvent {
  final String customerId;
  final String productId;
  final DateTime bookingDate;

  const AddBooking(this.customerId, this.productId, this.bookingDate);

  @override
  List<Object> get props => [customerId, productId, bookingDate];
}
