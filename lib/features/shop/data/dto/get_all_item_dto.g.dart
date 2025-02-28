// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_item_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllItemDTO _$GetAllItemDTOFromJson(Map<String, dynamic> json) =>
    GetAllItemDTO(
      success: json['success'] as bool,
      count: (json['count'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => ItemApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllItemDTOToJson(GetAllItemDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'data': instance.data,
    };
