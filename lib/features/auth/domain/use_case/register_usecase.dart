import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:infinistone/app/usecase/usecase.dart';
import 'package:infinistone/core/error/failure.dart';
import 'package:infinistone/features/auth/domain/entity/auth_entity.dart';
import 'package:infinistone/features/auth/domain/repository/auth_repository.dart';

class RegisterUserParams extends Equatable {
  final String fname;
  final String lname;
  final String email;
  final String phone;
  final String address;
  final String? image;
  final String password;

  const RegisterUserParams({
    required this.fname,
    required this.lname,
    required this.email,
    required this.phone,
    required this.address,
    this.image,
    required this.password,
  });

  //intial constructor
  const RegisterUserParams.initial({
    required this.fname,
    required this.lname,
    required this.email,
    required this.phone,
    required this.address,
    this.image,
    required this.password,
  });

  @override
  List<Object?> get props =>
      [fname, lname, email, phone, address, image, password];
}

class RegisterUseCase implements UsecaseWithParams<void, RegisterUserParams> {
  final IAuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final authEntity = AuthEntity(
      fname: params.fname,
      lname: params.lname,
      email: params.email,
      phone: params.phone,
      address: params.address,
      image: params.image,
      password: params.password,
    );
    return repository.registerUser(authEntity);
  }
}
