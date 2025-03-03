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
      product: json['product'] == null
          ? null
          : ItemApiModel.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookingApiModelToJson(BookingApiModel instance) =>
    <String, dynamic>{
      '_id': instance.bookingId,
      'customerId': instance.customerId,
      'productId': instance.productId,
      'product': instance.product,
      'bookingDate': instance.bookingDate.toIso8601String(),
    };
