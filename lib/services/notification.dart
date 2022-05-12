
import 'package:cloud_firestore/cloud_firestore.dart';



import 'package:firebase_auth/firebase_auth.dart' as auth;

import 'package:flutter/material.dart';




class NotificationServices {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  Stream<QuerySnapshot> getUserNotifications() {
    auth.User? user = _firebaseAuth.currentUser;
    print(user!.uid);
    return _firebaseFirestore
        .collection('notifications')
        .where('docId', isEqualTo: user != null ? user.uid : "")
        .snapshots();
  }
  
  Future<bool> setNotification(String userId,String patient,Function callBackError) async {
    CollectionReference<Map<dynamic, dynamic>> usersRef =
        _firebaseFirestore.collection('notifications');
    bool _flag = false;
    print("function set user");
    auth.User? user = _firebaseAuth.currentUser;
    
    if (user != null) {
        try {
          final data = {
        "approved":false,
        "docId":user.uid,
        "userId":userId,
        "patientName":patient,
        "doctorName":user.displayName,

      };
      await usersRef.add(data).then((value) => {
            //getting the user if exists
            _flag = true
          });
    } catch (e) {
      print("error");
      print(e);
      callBackError(e);
    }

    print("flag:$_flag");
    return _flag;
     
    } else {
      callBackError("Something Went Wrong. Try Again.");
      return _flag;
    }
  
  }

  Future<bool> updateNotification(String id,Function callBackError) async {
    CollectionReference<Map<dynamic, dynamic>> usersRef =
        _firebaseFirestore.collection('notifications');
    bool _flag = false;
    print("function set user");
    auth.User? user = _firebaseAuth.currentUser;
    
    if (user != null) {
        try {
      await usersRef.doc(id).update({
        "approved":true,
      }).then((value) => {
            //getting the user if exists
            _flag = true
          });
    } catch (e) {
      print("error");
      print(e);
      callBackError(e);
    }

    print("flag:$_flag");
    return _flag;
     
    } else {
      callBackError("Something Went Wrong. Try Again.");
      return _flag;
    }
  
  }

  
}
