// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_bookings_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllBookingsDTO _$GetAllBookingsDTOFromJson(Map<String, dynamic> json) =>
    GetAllBookingsDTO(
      success: json['success'] as bool,
      count: (json['count'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => BookingApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllBookingsDTOToJson(GetAllBookingsDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'data': instance.data,
    };
