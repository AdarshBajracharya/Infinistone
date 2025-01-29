part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class LoadImage extends RegisterEvent {
  final File file;

  const LoadImage({
    required this.file,
  });
}

class RegisterUser extends RegisterEvent {
  final BuildContext context;
  final String fName;
  final String lName;
  final String email;
  final String phone;
  final String address;
  final String? image;
  final String password;

  const RegisterUser({
    required this.context,
    required this.fName,
    required this.lName,
    required this.email,
    required this.phone,
    required this.address,
    this.image,
    required this.password,
  });
}
