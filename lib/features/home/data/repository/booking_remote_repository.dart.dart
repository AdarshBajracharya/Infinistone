import 'package:dartz/dartz.dart';
import 'package:infinistone/core/error/failure.dart';
import 'package:infinistone/features/home/data/data_source/remote_data_source/booking_remote_data_source.dart';
import 'package:infinistone/features/shop/domain/entity/booking_entity.dart';
import 'package:infinistone/features/shop/domain/repository/booking_repository.dart';

class BookingRemoteRepository implements IBookingRepository {
  final BookingRemoteDataSource remoteDataSource;

  BookingRemoteRepository({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> createBooking(BookingEntity booking) async {
    try {
      remoteDataSource.createBooking(booking);
      return const Right(null);
    } catch (e) {
      return Left(
        ApiFailure(
          message: ' REMOTE REPO ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteBooking(String id, String? token) async {
    try {
      remoteDataSource.deleteBooking(id, token);
      return const Right(null);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<BookingEntity>>> getBookings() async {
    try {
      final bookings = await remoteDataSource.getBookings();
      return Right(bookings);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }
}
