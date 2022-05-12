// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctors.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Doctors _$DoctorsFromJson(Map<String, dynamic> json) => Doctors(
      docId: json['docId'] as String,
      email: json['email'] as String,
      hospitalId: json['hospitalId'] as String,
      medicalId: json['medicalId'] as String,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      specialization: json['specialization'] as String,
    );

Map<String, dynamic> _$DoctorsToJson(Doctors instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'medicalId': instance.medicalId,
      'hospitalId': instance.hospitalId,
      'specialization': instance.specialization,
    };
