import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? userId;
  final String fName;
  final String lName;
  final String email;
  final String phone;
  final String address;
  // final int age;
  final String password;

  const AuthEntity({
    this.userId,
    required this.fName,
    required this.lName,
    required this.email,
    required this.phone,
    required this.address,
    // required this.age,
    required this.password,
  });

  @override
  List<Object?> get props =>
      [userId, fName, lName, email, phone, address, password];
}
