// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthApiModel _$AuthApiModelFromJson(Map<String, dynamic> json) => AuthApiModel(
      id: json['_id'] as String?,
      fname: json['fname'] as String,
      lname: json['lname'] as String,
      image: json['image'] as String?,
      email: json['email'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$AuthApiModelToJson(AuthApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'fname': instance.fname,
      'lname': instance.lname,
      'image': instance.image,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
      'password': instance.password,
    };
