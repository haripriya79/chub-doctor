
import 'package:json_annotation/json_annotation.dart';
part 'patients.g.dart';
@JsonSerializable()
class Patient{
  String userId;
  String userName;
  String phoneNumber;
  String email;
  String height;
  String weight;
  String allergies;
  String medication;
  String chronicalDiseases;
  Patient({required this.phoneNumber,required this.userId,required this.allergies,required this.chronicalDiseases,required this.email,required this.height,required this.medication,required this.userName,required this.weight});
  factory Patient.fromJson(Map<String, dynamic> json) => _$PatientFromJson(json);

  
  Map<String, dynamic> toJson() => _$PatientToJson(this);

}

