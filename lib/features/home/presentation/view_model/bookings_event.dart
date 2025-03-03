part of 'bookings_bloc.dart';

@immutable
sealed class BookingsEvent extends Equatable {
  const BookingsEvent();

  @override
  List<Object> get props => [];
}

final class LoadBookings extends BookingsEvent {}

class LoadImage extends BookingsEvent {
  final File file;

  const LoadImage({
    required this.file,
  });
}

final class AddBooking extends BookingsEvent {
  final BuildContext context;
  final String? bookingId;
  final String customerId;
  final String productId;
  final DateTime bookingDate;

  const AddBooking(this.bookingId, this.context, this.customerId,
      this.productId, this.bookingDate);

  @override
  List<Object> get props => [context, customerId, productId, bookingDate];
}

final class DeleteBooking extends BookingsEvent {
  final String bookingId;

  const DeleteBooking(this.bookingId);

  @override
  List<Object> get props => [bookingId];
}
