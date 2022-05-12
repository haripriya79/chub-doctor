import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_consultation_app/firebase_options.dart';
import 'package:doctor_consultation_app/modules/consultations.dart';
import 'package:doctor_consultation_app/modules/doctors.dart';
import 'package:doctor_consultation_app/utils/errorCallback.dart';
// import 'package:doctor_app/firebase_options.dart';
// import 'package:doctor_app/models/consultations.dart';
// import 'package:doctor_app/models/patients.dart';
// import 'package:doctor_app/utils/errorCallback.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseConfig.platformOptions,
  );
  //ConsultationServices().setDocConsultations((e) => toastMesssage(e));
}

class ConsultationServices {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;


  Future<bool> setDoctorConsultations(Function callBackError,String userId,String  name,String description,File file,String fileName) async {
    CollectionReference<Map<dynamic, dynamic>> usersRef =
        _firebaseFirestore.collection('consultations');
    bool _flag = false;
    print("function set user");
    auth.User? user = _firebaseAuth.currentUser;
    Doctors doctors;
    Consultation _consultation;
    String url = await uploadFile(file, fileName);
    if (user != null) {
      _consultation = Consultation(
          docName: "Yogendra",
          docPhoneNumber: "1234567890",
          userId:userId ,
          appointmentDate: "22 Mar 2022 ",
          docEmail: "doctor123@gmail.com",
          appointmentName: "Dental Appointment",
          docId: user.uid,
          generalNotes: "The the Description",
          records: [
            {
             "Blood Report":[url,fileName],
            }
          ]);
    } else {
      callBackError("Something Went Wrong. Try Again.");
      return _flag;
    }
    try {
      await usersRef.add(_consultation.toJson()).then((value) => {
            //getting the user if exists
            _flag = true
          });
    } catch (e) {
      print("error");
      print(e);
    }

    print("flag:$_flag");
    return _flag;
  }

  Stream<QuerySnapshot> getDoctorConsultations() {
    auth.User? user = _firebaseAuth.currentUser;

    return _firebaseFirestore
        .collection('consultations')
        .where('docId', isEqualTo: user != null ? user.uid : "")
        .snapshots();
  }
  Future uploadFile(idFile,fileName) async {
    
       WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      
    );
     FirebaseStorage storage =
      FirebaseStorage.instance;
    if (idFile == null) return;
    
    final destination = 'files/$fileName';

    try {
      final ref = FirebaseStorage.instance
          .ref(destination)
          .child('file/');
      TaskSnapshot
       task =   await ref.putFile(idFile! );
      return   await task.ref.getDownloadURL();
    } catch (e) {
      print(e);
      print('error occured');
    }
    
  }

  Future<void> downloadFileExample(url,string) async {
    //First you get the documents folder location on the device...
    Directory appDocDir = await getApplicationDocumentsDirectory();
    //Here you'll specify the file it should be saved as

    File downloadToFile = File('${appDocDir.path}/$string');
    //Here you'll specify the file it should download from Cloud Storage
   
    //Now you can try to download the specified file, and write it to the downloadToFile.
    try {
     await FirebaseStorage.instance
          .refFromURL(url)
          .writeToFile(downloadToFile);
      OpenFile.open(downloadToFile.path,);
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      print('Download error: $e');
    }
  }
}
