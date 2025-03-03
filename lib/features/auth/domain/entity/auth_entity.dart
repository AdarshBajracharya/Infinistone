import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? userId;
  final String fname;
  final String lname;
  final String email;
  final String phone;
  final String address;
  final String? image;
  final String? password;

  const AuthEntity({
    this.userId,
    required this.fname,
    required this.lname,
    required this.email,
    required this.phone,
    required this.address,
    this.image,
    this.password,
  });

  @override
  List<Object?> get props =>
      [userId, fname, lname, image, email, phone, address, password];

  static fromJson(Map<String, dynamic> userMap) {
    return AuthEntity(
      userId: userMap['userId'],
      fname: userMap['fname'] ?? '',
      lname: userMap['lname'] ?? '',
      email: userMap['email'] ?? '',
      phone: userMap['phone'] ?? '',
      address: userMap['address'] ?? '',
      image: userMap['image'],
      password: '',
    );
  }
}
