import 'package:equatable/equatable.dart';
import 'package:infinistone/features/shop/domain/entity/item_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item_api_model.g.dart';

@JsonSerializable()
class ItemApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? itemId;
  final String itemName;
  final String itemType;
  final String itemInfo;
  final double itemPrice;
  final String? itemImage;

  const ItemApiModel({
    this.itemId,
    required this.itemName,
    required this.itemType,
    required this.itemInfo,
    required this.itemPrice,
    this.itemImage,
  });

  const ItemApiModel.empty()
      : itemId = '',
        itemName = '',
        itemType = '',
        itemInfo = '',
        itemPrice = 0,
        itemImage = '';

  // From Json , write full code without generator
  factory ItemApiModel.fromJson(Map<String, dynamic> json) {
    return ItemApiModel(
      itemId: json['_id']?.toString() ?? '',
      itemName: json['item_name']?.toString() ?? '',
      itemType: json['item_type']?.toString() ?? '',
      itemInfo: json['item_description']?.toString() ?? '',
      itemPrice: (json['item_price'] is int)
          ? (json['item_price'] as int).toDouble()
          : json['item_price'] as double,
      itemImage: json['image'] ?? '',
    );
  }

  // To Json , write full code without generator
  Map<String, dynamic> toJson() {
    return {
      '_id': itemId,
      'item_name': itemName,
      'item_type': itemType,
      'item_description': itemInfo,
      'item_price': itemPrice,
      'image': itemImage?.isEmpty ?? true ? null : itemImage,
    };
  }

  // Convert API Object to Entity
  ItemEntity toEntity() => ItemEntity(
        itemId: itemId,
        itemName: itemName,
        itemType: itemType,
        itemInfo: itemInfo,
        itemPrice: itemPrice,
        itemImage: itemImage ?? '',
      );

  // Convert Entity to API Object
  static ItemApiModel fromEntity(ItemEntity entity) => ItemApiModel(
        itemName: entity.itemName,
        itemType: entity.itemType,
        itemInfo: entity.itemInfo,
        itemPrice: entity.itemPrice,
        itemImage: entity.itemImage,
      );

  // Convert API List to Entity List
  static List<ItemEntity> toEntityList(List<ItemApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props =>
      [itemId, itemName, itemType, itemImage, itemInfo, itemPrice];
}
