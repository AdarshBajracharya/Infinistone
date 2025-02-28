// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingApiModel _$BookingApiModelFromJson(Map<String, dynamic> json) =>
    BookingApiModel(
      bookingId: json['_id'] as String?,
      customerId: json['customerId'] as String,
      productId: json['productId'] as String,
      bookingDate: DateTime.parse(json['bookingDate'] as String),
    );

Map<String, dynamic> _$BookingApiModelToJson(BookingApiModel instance) =>
    <String, dynamic>{
      '_id': instance.bookingId,
      'customerId': instance.customerId,
      'productId': instance.productId,
      'bookingDate': instance.bookingDate.toIso8601String(),
    };
