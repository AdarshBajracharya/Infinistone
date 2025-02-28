import 'package:equatable/equatable.dart';

class ItemEntity extends Equatable {
  final String? itemId;
  final String itemName;
  final String itemType;
  final String itemInfo;
  final double itemPrice;
  final String? itemImage;

  const ItemEntity({
    this.itemId,
    required this.itemName,
    required this.itemType,
    required this.itemInfo,
    required this.itemPrice,
    this.itemImage,
  });

  @override
  List<Object?> get props => [itemId, itemName, itemType, itemImage, itemInfo, itemPrice];
}
