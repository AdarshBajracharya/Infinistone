import 'package:equatable/equatable.dart';

class BookingEntity extends Equatable {
  final String? bookingId; 
  final String customerId; 
  final String productId; 
  final DateTime bookingDate; 

  const BookingEntity({
    this.bookingId,
    required this.customerId,
    required this.productId,
    required this.bookingDate,
  });

  @override
  List<Object?> get props => [bookingId, customerId, productId, bookingDate];
}