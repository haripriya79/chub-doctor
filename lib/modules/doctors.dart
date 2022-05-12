import 'package:json_annotation/json_annotation.dart';
part 'doctors.g.dart';
@JsonSerializable()

class Doctors{
  String name;
  String email;
  String phoneNumber;
  String medicalId;
  String hospitalId;
  String specialization;
  String docId;

  Doctors({required this.docId,required this.email,required this.hospitalId,required this.medicalId,required this.name,required this.phoneNumber,required this.specialization});
   factory Doctors.fromJson(Map<String, dynamic> json) => _$DoctorsFromJson(json);

  
  Map<String, dynamic> toJson() => _$DoctorsToJson(this);

}