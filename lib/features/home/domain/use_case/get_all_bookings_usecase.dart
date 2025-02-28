import 'package:dartz/dartz.dart';
import 'package:infinistone/app/usecase/usecase.dart';
import 'package:infinistone/core/error/failure.dart';
import 'package:infinistone/features/shop/domain/entity/booking_entity.dart';
import 'package:infinistone/features/shop/domain/repository/booking_repository.dart';


class GetAllBookingsUseCase implements UsecaseWithoutParams<List<BookingEntity>> {
  final IBookingRepository bookingRepository;

  GetAllBookingsUseCase({required this.bookingRepository});

  @override
  Future<Either<Failure, List<BookingEntity>>> call() {
    print('GetAllBookingUseCase called');
    return bookingRepository.getBookings();
  }
}
