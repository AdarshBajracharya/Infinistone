import 'package:dartz/dartz.dart';
import 'package:infinistone/core/error/failure.dart';
import 'package:infinistone/features/shop/domain/entity/booking_entity.dart';

abstract interface class IBookingRepository {
  Future<Either<Failure, List<BookingEntity>>> getBookings();
  Future<Either<Failure, void>> createBooking(BookingEntity booking);
  Future<Either<Failure, void>> deleteBooking(String id, String? token);
}
