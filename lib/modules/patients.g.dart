// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patients.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Patient _$PatientFromJson(Map<String, dynamic> json) => Patient(
      phoneNumber: json['phoneNumber'] as String,
      userId: json['userId'] as String,
      allergies: json['allergies'] as String,
      chronicalDiseases: json['chronicalDiseases'] as String,
      email: json['email'] as String,
      height: json['height'] as String,
      medication: json['medication'] as String,
      userName: json['userName'] as String,
      weight: json['weight'] as String,
    );

Map<String, dynamic> _$PatientToJson(Patient instance) => <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'height': instance.height,
      'weight': instance.weight,
      'allergies': instance.allergies,
      'medication': instance.medication,
      'chronicalDiseases': instance.chronicalDiseases,
    };
