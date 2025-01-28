import 'package:equatable/equatable.dart';
import 'package:infinistone/features/auth/domain/entity/auth_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String fname;
  final String lname;
  final String? image;
  final String email;
  final String phone;
  final String address;
  final String? password;

  const AuthApiModel({
    this.id,
    required this.fname,
    required this.lname,
    required this.image,
    required this.email,
    required this.phone,
    required this.address,
    required this.password,
  });

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  // To Entity
  AuthEntity toEntity() {
    return AuthEntity(
      userId: id,
      fName: fname,
      lName: lname,
      email: email,
      phone: phone,
      address: address,
      password: password ?? '',
    );
  }

  // From Entity
  factory AuthApiModel.fromEntity(AuthEntity entity) {
    return AuthApiModel(
      fname: entity.fName,
      lname: entity.lName,
      image: entity.image,
      email: entity.email,
      phone: entity.phone,
      address: entity.address,
      password: entity.password,
    );
  }

  @override
  List<Object?> get props =>
      [fname, lname, image, email, phone, address, password];
}
