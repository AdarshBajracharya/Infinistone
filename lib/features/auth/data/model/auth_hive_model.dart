import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:infinistone/app/constants/hive_table_constant.dart';
import 'package:infinistone/features/auth/domain/entity/auth_entity.dart';
import 'package:uuid/uuid.dart';

part 'auth_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.userTableId)
class AuthHiveModel extends Equatable {
  @HiveField(0)
  final String? userId;
  @HiveField(1)
  final String fName;
  @HiveField(2)
  final String lName;
  @HiveField(3)
  final String email;
  @HiveField(4)
  final String phone;
  @HiveField(5)
  final String address;
  @HiveField(6)
  final String password;

  AuthHiveModel({
    String? userId,
    required this.fName,
    required this.lName,
    required this.email,
    required this.phone,
    required this.address,
    // required this.age,
    required this.password,
  }) : userId = userId ?? const Uuid().v4();

  // Initial Constructor
  const AuthHiveModel.initial()
      : userId = '',
        fName = '',
        lName = '',
        email = '',
        phone = '',
        address = '',
        password = '';

  // From Entity
  factory AuthHiveModel.fromEntity(AuthEntity entity) {
    return AuthHiveModel(
      userId: entity.userId,
      fName: entity.fName,
      lName: entity.lName,
      email: entity.email,
      phone: entity.phone,
      address: entity.address,
      // age: entity.age,
      password: entity.password,
    );
  }

  // To Entity
  AuthEntity toEntity() {
    return AuthEntity(
      userId: userId,
      fName: fName,
      lName: lName,
      email: email,
      phone: phone,
      address: address,
      // age: age,
      password: password,
    );
  }

  @override
  List<Object?> get props =>
      [userId, fName, lName, email, phone, address, password];
}