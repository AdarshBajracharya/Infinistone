import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:infinistone/app/usecase/usecase.dart';
import 'package:infinistone/core/error/failure.dart';
import 'package:infinistone/features/shop/domain/entity/booking_entity.dart';
import 'package:infinistone/features/shop/domain/repository/booking_repository.dart';

class CreateBookingParams extends Equatable {
  final String customerId;
  final String productId;
  final DateTime bookingDate;

  const CreateBookingParams({
    required this.customerId,
    required this.productId,
    required this.bookingDate,
  });

  // Empty constructor
  CreateBookingParams.empty()
      : customerId = '_empty.string',
        productId = '_empty.string',
        bookingDate = DateTime.now();

  @override
  List<Object?> get props => [customerId, productId, bookingDate];
}

class CreateBookingUseCase
    implements UsecaseWithParams<void, CreateBookingParams> {
  final IBookingRepository bookingRepository;

  CreateBookingUseCase({required this.bookingRepository});

  @override
  Future<Either<Failure, void>> call(CreateBookingParams params) async {
    return await bookingRepository.createBooking(
      BookingEntity(
        customerId: params.customerId,
        productId: params.productId,
        bookingDate: params.bookingDate,
      ),
    );
  }
}
