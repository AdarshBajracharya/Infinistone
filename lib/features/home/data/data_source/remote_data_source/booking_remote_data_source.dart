import 'package:dio/dio.dart';
import 'package:infinistone/app/constants/api_endpoints.dart';
import 'package:infinistone/app/shared_prefs/token_shared_prefs.dart';
import 'package:infinistone/features/home/data/data_source/booking_data_source.dart';
import 'package:infinistone/features/home/data/dto/get_all_bookings_dto.dart';
import 'package:infinistone/features/home/data/model/booking_api_model.dart';
import 'package:infinistone/features/shop/domain/entity/booking_entity.dart';

class BookingRemoteDataSource implements IBookingDataSource {
  final Dio _dio;
  final TokenSharedPrefs _tokenSharedPrefs;

  BookingRemoteDataSource(this._dio, this._tokenSharedPrefs);

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
      print('VAL: JSON: DELETE $token');
      var response = await _dio.delete(
        '${ApiEndpoints.deleteBooking}$id',
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
      var userIdResponse = await _tokenSharedPrefs.getUser();
      print('VAL: USERID: $userIdResponse');
      var tokenResult = await _tokenSharedPrefs.getToken();
      var token = tokenResult.fold(
        (failure) => throw Exception("Failed to get token"),
        (token) => token,
      );
      print('VAL: USERID:token $token');
      var id = userIdResponse?['_id'];
      print('VAL: USERID: $id');
      var response = await _dio.get(
        ApiEndpoints.getAllBookings,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      print('VAL: JSON:5 $response');

      GetAllBookingsDTO bookingDTO = GetAllBookingsDTO.fromJson(response.data);
      var val = BookingApiModel.toEntityList(bookingDTO.data);
      print("VAL: $val");
      return val;
    } on DioException catch (e) {
      throw Exception((e));
    } catch (e) {
      throw Exception(' REMOTE DS ${e.toString()}');
    }
  }
}
