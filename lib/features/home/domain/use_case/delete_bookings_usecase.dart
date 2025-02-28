import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:infinistone/app/shared_prefs/token_shared_prefs.dart';
import 'package:infinistone/app/usecase/usecase.dart';
import 'package:infinistone/core/error/failure.dart';
import 'package:infinistone/features/shop/domain/repository/booking_repository.dart';
import 'package:infinistone/features/shop/domain/repository/item_repository.dart';

class DeleteBookingParams extends Equatable {
  final String bookingId;

  const DeleteBookingParams({required this.bookingId});

  const DeleteBookingParams.empty() : bookingId = '_empty.string';

  @override
  List<Object?> get props => [bookingId];
}

class DeleteBookingUsecase implements UsecaseWithParams<void, DeleteBookingParams> {
  final IBookingRepository bookingRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  DeleteBookingUsecase({
    required this.bookingRepository,
    required this.tokenSharedPrefs,
  });

  @override
  Future<Either<Failure, void>> call(DeleteBookingParams params) async {
    // Get token from Shared Preferences and send it to the server
    final token = await tokenSharedPrefs.getToken();
    return token.fold((l) {
      return Left(l);
    }, (r) async {
      return await bookingRepository.deleteBooking(params.bookingId, r);
    });
  }
}
