import 'package:dartz/dartz.dart';
import 'package:infinistone/app/usecase/usecase.dart';
import 'package:infinistone/core/error/failure.dart';
import 'package:infinistone/features/auth/domain/entity/auth_entity.dart';
import 'package:infinistone/features/auth/domain/repository/auth_repository.dart';

class UpdateUserUsecase implements UsecaseWithParams<void, AuthEntity> {
  final IAuthRepository repository;

  UpdateUserUsecase(this.repository);

  @override
  Future<Either<Failure, AuthEntity>> call(AuthEntity params) async {
    try {
      final authEntity = AuthEntity(
        fname: params.fname,
        lname: params.lname,
        email: params.email,
        phone: params.phone,
        address: params.address,
        image: params.image,
      );
      print('AUTHENTITY::: $authEntity');
      return repository.updateUser(authEntity);
    } catch (e) {
      return Left(
        SharedPrefsFailure(
            message: 'Unexpected error occurred: ${e.toString()}'),
      );
    }
  }
}
