import 'package:json_annotation/json_annotation.dart';
part 'consultations.g.dart';
@JsonSerializable()

class Consultation{
  String userId;
  String appointmentDate;
  String docPhoneNumber;
  String docName;
  List<Map<String,List<String>>> records;
  String docId;
  String generalNotes;
  String appointmentName;
  String docEmail;
  Consultation({required this.docName,required this.userId,required this.appointmentDate,required this.docEmail,required this.appointmentName,required this.docId,required this.docPhoneNumber,required this.generalNotes,required this.records});
  factory Consultation.fromJson(Map<String, dynamic> json) => _$ConsultationFromJson(json);

 
  Map<String, dynamic> toJson() => _$ConsultationToJson(this);

}