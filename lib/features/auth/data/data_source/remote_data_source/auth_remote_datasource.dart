import 'dart:io';

import 'package:dio/dio.dart';
import 'package:infinistone/app/constants/api_endpoints.dart';
import 'package:infinistone/app/shared_prefs/token_shared_prefs.dart';
import 'package:infinistone/features/auth/data/data_source/auth_data_source.dart';
import 'package:infinistone/features/auth/domain/entity/auth_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRemoteDatasource implements IAuthDataSource {
  final Dio _dio;
  final TokenSharedPrefs userIdSharedPrefs;

  AuthRemoteDatasource(this._dio, this.userIdSharedPrefs);

  @override
  Future<AuthEntity> getCurrentUser(String? token, String userId) async {
    try {
      Response response = await _dio.get(
        '${ApiEndpoints.getUser}/$userId',
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];
        print("DATA::: $data");
        if (data == null) {
          throw Exception("User not found");
        }
        return AuthEntity(
          fname: data['fname'] ?? '',
          lname: data['lname'] ?? '',
          image: data['image'] ?? '',
          email: data['email'] ?? '',
          phone: data['phone'] ?? '',
          address: data['address'] ?? '',
          password: '',
        );
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'An error occurred');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> registerUser(AuthEntity user) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.register,
        data: {
          "fname": user.fname,
          "lname": user.lname,
          "phone": user.phone,
          "image": user.image,
          "email": user.email,
          "address": user.address,
          "password": user.password,
        },
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
  Future<String> loginUser(String email, String password) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.login,
        data: {
          "email": email,
          "password": password,
        },
      );

      // Debugging: Print the raw response
      print("Raw API Response: ${response.data}");

      // Ensure response is valid and contains expected keys
      if (response.statusCode == 200 && response.data != null) {
        if (response.data is Map<String, dynamic>) {
          final str = response.data['token'];
          final cred = response.data['user'];
          final userId = cred['_id']; // Assuming the user ID is stored in '_id'

          // Save userId to shared preferences
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('userId', userId);
          print("CRED::: ${response.data}");

          if (cred != null) {
            userIdSharedPrefs.setUser(cred);
            print("USER SAVED:::: $cred");
          } else {
            print("WARNING: 'cred' is null in API response.");
          }

          return str ?? (throw Exception("Token is null in response"));
        } else {
          throw Exception("Unexpected response format: ${response.data}");
        }
      } else {
        throw Exception(response.statusMessage ?? "Invalid credentials");
      }
    } on DioException catch (e) {
      print("Dio Error: ${e.response?.data}"); // Debug DioException details
      return Future.error("Network error: ${e.message}");
    } catch (e) {
      print("Unexpected Error: $e");
      return Future.error("Unexpected error: $e");
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap(
        {
          'profilePicture': await MultipartFile.fromFile(
            file.path,
            filename: fileName,
          ),
        },
      );
      Response response = await _dio.post(
        ApiEndpoints.uploadImage,
        data: formData,
      );
      if (response.statusCode == 200) {
        return response.data['data'];
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
  Future<AuthEntity> updateUser(AuthEntity updatedUser) async {
    try {
      // First, get the current user data from SharedPreferences
      var currentUser = await userIdSharedPrefs.getUser();
      // Map<String, dynamic>? currentUser =
      print("Current user before update: $currentUser");

      // Prepare updated data by merging the current user data and the new data
      try {
        currentUser?['fname'] = updatedUser.fname;
        currentUser?['lname'] = updatedUser.lname;
        currentUser?['email'] = updatedUser.email;
        currentUser?['phone'] = updatedUser.phone;
        currentUser?['address'] = updatedUser.address;
        currentUser?['image'] = updatedUser.image;
      } catch (e) {
        print('Error $e');
      }
      var id = currentUser?['_id'];
      if (updatedUser.image != null) {
        currentUser?['image'] =
            await MultipartFile.fromFile(updatedUser.image!);
      } else {
        currentUser!.remove('image');
      }

      print("abc::: $currentUser");

      currentUser?.remove('__v');
      var url = ApiEndpoints.updateUser + id;
      print("URL::: $url");
      // Send the update request to the backend API
      Response response = await _dio.put(
        ApiEndpoints.updateUser + id,
        data: currentUser,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
          },
        ),
      );

      print("API Endpoint: $response");

      if (response.statusCode == 200) {
        // On success, update the local SharedPreferences with the new user data
        Map<String, dynamic> newUserData = response.data['data'];
        await userIdSharedPrefs.updateUser(
          newUserData,
        ); // Save updated user data in SharedPreferences

        print("Updated user data saved in SharedPreferences: $newUserData");

        // Return the updated user entity
        return AuthEntity.fromJson(newUserData);
      } else {
        print("No Data updated $currentUser");
        throw Exception('Failed to update user: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Error updating user: $e');
    }
  }
}
