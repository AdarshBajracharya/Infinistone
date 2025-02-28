import 'package:infinistone/features/home/data/model/booking_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_bookings_dto.g.dart';

@JsonSerializable()
class GetAllBookingsDTO {
  final bool success;
  final int count;
  final List<BookingApiModel> data;

  GetAllBookingsDTO({
    required this.success,
    required this.count,
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetAllBookingsDTOToJson(this);

  factory GetAllBookingsDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllBookingsDTOFromJson(json);
}
