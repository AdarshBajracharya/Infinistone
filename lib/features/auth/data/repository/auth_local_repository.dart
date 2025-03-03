import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:infinistone/app/shared_prefs/token_shared_prefs.dart';
import 'package:infinistone/core/error/failure.dart';
import 'package:infinistone/features/auth/data/data_source/local_data_source/auth_local_datasource.dart';
import 'package:infinistone/features/auth/domain/entity/auth_entity.dart';
import 'package:infinistone/features/auth/domain/repository/auth_repository.dart';

class AuthLocalRepository implements IAuthRepository {
  final AuthLocalDataSource _authLocalDataSource;
   final TokenSharedPrefs userIdSharedPrefs;

  AuthLocalRepository(this._authLocalDataSource,this.userIdSharedPrefs);

  // @override
  // Future<Either<Failure, AuthEntity>> getCurrentUser() async {
  //   try {
  //     final currentUser = await _authLocalDataSource.getCurrentUser();
  //     return Right(currentUser);
  //   } catch (e) {
  //     return Left(LocalDatabaseFailure(message: e.toString()));
  //   }
  // }

  @override
  Future<Either<Failure, String>> loginUser(
    String email,
    String password,
  ) async {
    try {
      final token = await _authLocalDataSource.loginUser(email, password);
      return Right(token);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> registerUser(AuthEntity user) async {
    try {
      return Right(_authLocalDataSource.registerUser(user));
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    // TODO: implement uploadProfilePicture
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser(String? token, String userID) {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }
    @override
Future<Either<Failure, AuthEntity>> updateUser(AuthEntity user){
   // TODO: implement getCurrentUser
    throw UnimplementedError();
}
 
}
