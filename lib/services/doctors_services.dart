import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_consultation_app/modules/doctors.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';

class DoctorServices {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  Stream<QuerySnapshot> userProfileStream() {
    WidgetsFlutterBinding.ensureInitialized();
    // Firebase.initializeApp(options:DefaultFirebaseConfig.platformOptions,);
    auth.User? user = _firebaseAuth.currentUser;

    return FirebaseFirestore.instance
        .collection('doctors')
        .where('userId', isEqualTo: user != null ? user.uid : "")
        .snapshots();
  }

  Future<bool> setUser(
      String name,
  String email,
  String phoneNumber,
  String medicalId,
  String hospitalId,
  String specialization,
  String docId,
      
      Function callBackError) async {
    CollectionReference<Map<dynamic, dynamic>> usersRef =
        _firebaseFirestore.collection('doctors');
    bool _flag = false;
    print("function set user");
    auth.User? user = _firebaseAuth.currentUser;
    Doctors _doctor;
    if (user != null) {
      _doctor = Doctors(docId: docId, email: email, hospitalId: hospitalId, medicalId: medicalId, name: name, phoneNumber: phoneNumber, specialization: specialization);
    } else {
      callBackError("Something Went Wrong. Try Again.");
      return _flag;
    }
    try {
      await usersRef.doc(user.uid).set(_doctor.toJson()).then((value) => {

            _flag = true
          });
    } catch (e) {
      callBackError(e.toString());
    }

    print("flag:$_flag");
    return _flag;
  }
}
