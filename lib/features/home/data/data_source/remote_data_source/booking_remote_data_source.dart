import 'package:dio/dio.dart';
import 'package:infinistone/app/constants/api_endpoints.dart';
import 'package:infinistone/features/home/data/data_source/booking_data_source.dart';
import 'package:infinistone/features/home/data/dto/get_all_bookings_dto.dart';
import 'package:infinistone/features/home/data/model/booking_api_model.dart';
import 'package:infinistone/features/shop/domain/entity/booking_entity.dart';

class BookingRemoteDataSource implements IBookingDataSource {
  final Dio _dio;

  BookingRemoteDataSource(this._dio);

  @override
  Future<void> createBooking(BookingEntity booking) async {
    try {
      // Convert entity to model
      var bookingApiModel = BookingApiModel.fromEntity(booking);
      var response = await _dio.post(
        ApiEndpoints.createBooking,
        data: bookingApiModel.toJson(),
      );
      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteBooking(String id, String? token) async {
    try {
      var response = await _dio.delete(
        ApiEndpoints.deleteBooking + id,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<BookingEntity>> getBookings() async {
    try {
      var response = await _dio.get(
        ApiEndpoints.getAllBookings,
      );

      GetAllBookingsDTO bookingDTO = GetAllBookingsDTO.fromJson(response.data);
      return BookingApiModel.toEntityList(bookingDTO.data);
    } on DioException catch (e) {
      throw Exception((e));
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}