
// import 'package:doctor_app/firebase_options.dart';
// import 'package:doctor_app/models/patients.dart';
// import 'package:doctor_app/services/patients_services.dart';
import 'package:doctor_consultation_app/firebase_options.dart';
import 'package:doctor_consultation_app/modules/doctors.dart';
import 'package:doctor_consultation_app/services/doctors_services.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth; // new
import 'package:firebase_core/firebase_core.dart'; // new



class AuthServices{

  

  //for streaming the user changes
  Stream<auth.User?> userChanges() {
   
    Firebase.initializeApp(options:DefaultFirebaseConfig.platformOptions,);
    
    print("listening to changes");
    return auth.FirebaseAuth.instance.userChanges() ;
  }


  
  Future<void> signout() async {
    Firebase.initializeApp(options:DefaultFirebaseConfig.platformOptions,);
    await auth.FirebaseAuth.instance.signOut();
    
  }

  Future<bool> signInWithEmailAndPassword(
    String email,
    String password,
    void Function(auth.FirebaseAuthException e) errorCallback,
  ) async {
    try {
      var credential =
          await auth.FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(credential.user!.displayName);
      return credential.user != null;
    } on auth.FirebaseAuthException catch (e) {
      errorCallback(e);
    }
    return false;
  }

  Future<bool> signUpWithEmailAndPassword(name,password, email, phoneNumber, medicalId, hospitalId, specialization, void Function(String e) callBackError) async {
        bool _flag = false;
    try {
      var credential = await auth.FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password,);
      await credential.user!.updateDisplayName(name);   
      
      _flag = await DoctorServices().setUser(name, email, phoneNumber, medicalId, hospitalId, specialization, credential.user!.uid, callBackError);
      if(!_flag){
        if(credential.user!=null){
          credential.user!.delete();

        }
       
        

      }
    
    } on auth.FirebaseAuthException catch (e) {
      callBackError(e.code);
    }
    return _flag;
  }
}
