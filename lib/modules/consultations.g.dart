// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consultations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Consultation _$ConsultationFromJson(Map<String, dynamic> json) => Consultation(
      docName: json['docName'] as String,
      userId: json['userId'] as String,
      appointmentDate: json['appointmentDate'] as String,
      docEmail: json['docEmail'] as String,
      appointmentName: json['appointmentName'] as String,
      docId: json['docId'] as String,
      docPhoneNumber: json['docPhoneNumber'] as String,
      generalNotes: json['generalNotes'] as String,
      records: (json['records'] as List<dynamic>)
          .map((e) => (e as Map<String, dynamic>).map(
                (k, e) => MapEntry(
                    k, (e as List<dynamic>).map((e) => e as String).toList()),
              ))
          .toList(),
    );

Map<String, dynamic> _$ConsultationToJson(Consultation instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'appointmentDate': instance.appointmentDate,
      'docPhoneNumber': instance.docPhoneNumber,
      'docName': instance.docName,
      'records': instance.records,
      'docId': instance.docId,
      'generalNotes': instance.generalNotes,
      'appointmentName': instance.appointmentName,
      'docEmail': instance.docEmail,
    };
