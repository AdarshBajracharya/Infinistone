import 'package:equatable/equatable.dart';
import 'package:infinistone/features/shop/data/model/item_api_model.dart';
import 'package:infinistone/features/shop/domain/entity/booking_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'booking_api_model.g.dart';

@JsonSerializable()
class BookingApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? bookingId;
  final String customerId;
  final String productId;
  final ItemApiModel? product;
  final DateTime bookingDate;

  const BookingApiModel({
    this.bookingId,
    required this.customerId,
    required this.productId,
    required this.bookingDate,
    this.product,
  });

  BookingApiModel.empty()
      : bookingId = '',
        customerId = '',
        productId = '',
        product = const ItemApiModel.empty(),
        bookingDate = DateTime.now();

  // From Json , write full code without generator
  factory BookingApiModel.fromJson(Map<String, dynamic> json) {
    try {
      var Booking = BookingApiModel(
        bookingId: json['_id']?.toString() ?? '',
        customerId: json['customer']?['fname'].toString() ?? '',
        productId: json['product']?['item_name'].toString() ?? '',
        product: json['product'] != null
            ? ItemApiModel.fromJson(json['product'])
            : const ItemApiModel.empty(),
        bookingDate: DateTime.parse(
            json['bookingDate']?.toString() ?? DateTime.now().toString()),
      );
      print('BookingApiModel.fromJson: $Booking');
      return Booking;
    } catch (e) {
      print('BookingApiModel.fromJson: $e');
      return BookingApiModel.empty();
    }
  }

  // To Json , write full code without generator
  Map<String, dynamic> toJson() {
    return {
      // '_id': bookingId,
      'customerId': customerId,
      'productId': productId,
      'bookingDate': bookingDate.toIso8601String(),
    };
  }

  // Convert API Object to Entity
  BookingEntity toEntity() => BookingEntity(
        bookingId: bookingId,
        customerId: customerId,
        productId: productId,
        bookingDate: bookingDate,
      );

  // Convert Entity to API Object
  static BookingApiModel fromEntity(BookingEntity entity) => BookingApiModel(
        bookingId: entity.bookingId,
        customerId: entity.customerId,
        productId: entity.productId,
        bookingDate: entity.bookingDate,
      );

  // Convert API List to Entity List
  static List<BookingEntity> toEntityList(List<BookingApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [];
}
