import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_consultation_app/modules/patients.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';

class PatientServices {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  Stream<QuerySnapshot> userProfileStream() {
    WidgetsFlutterBinding.ensureInitialized();
    // Firebase.initializeApp(options:DefaultFirebaseConfig.platformOptions,);
    auth.User? user = _firebaseAuth.currentUser;

    return FirebaseFirestore.instance
        .collection('patients')
        .snapshots();
  }
    Stream<QuerySnapshot> getPatientStream(userId) {
    WidgetsFlutterBinding.ensureInitialized();
    // Firebase.initializeApp(options:DefaultFirebaseConfig.platformOptions,);
    

    return FirebaseFirestore.instance
        .collection('patients')
        .where("userId",isEqualTo: userId)
        .snapshots();
  }

  Future<bool> setUser(
      String height,
      String weight,
      String allergies,
      String medication,
      String chronicalDiseases,
      String phoneNumber,
      Function callBackError) async {
    CollectionReference<Map<dynamic, dynamic>> usersRef =
        _firebaseFirestore.collection('patients');
    bool _flag = false;
    print("function set user");
    auth.User? user = _firebaseAuth.currentUser;
    Patient _patient;
    if (user != null) {
      _patient = Patient(
          phoneNumber: phoneNumber,
          userId: user.uid,
          allergies: allergies,
          chronicalDiseases: chronicalDiseases,
          email: user.email!,
          height: height,
          medication: medication,
          userName: user.displayName!,
          weight: weight);
    } else {
      callBackError("Something Went Wrong. Try Again.");
      return _flag;
    }
    try {
      await usersRef.doc(user.uid).set(_patient.toJson()).then((value) => {
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
}
