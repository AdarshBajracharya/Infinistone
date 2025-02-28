// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemApiModel _$ItemApiModelFromJson(Map<String, dynamic> json) => ItemApiModel(
      itemId: json['_id'] as String?,
      itemName: json['itemName'] as String,
      itemType: json['itemType'] as String,
      itemInfo: json['itemInfo'] as String,
      itemPrice: (json['itemPrice'] as num).toDouble(),
      itemImage: json['itemImage'] as String?,
    );

Map<String, dynamic> _$ItemApiModelToJson(ItemApiModel instance) =>
    <String, dynamic>{
      '_id': instance.itemId,
      'itemName': instance.itemName,
      'itemType': instance.itemType,
      'itemInfo': instance.itemInfo,
      'itemPrice': instance.itemPrice,
      'itemImage': instance.itemImage,
    };
