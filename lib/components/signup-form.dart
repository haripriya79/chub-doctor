
import 'package:doctor_consultation_app/constant.dart';
import 'package:doctor_consultation_app/screens/home_screen.dart';
import 'package:doctor_consultation_app/screens/loading_dailog.dart';
import 'package:doctor_consultation_app/screens/sign_up.dart';
import 'package:doctor_consultation_app/services/auth_service.dart';
import 'package:doctor_consultation_app/utils/errorCallback.dart';
import 'package:doctor_consultation_app/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';


class SignUpForm extends StatelessWidget {
    SignUpForm({
    Key? key,
   
  }) : super(key: key);

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  late String _username, _email, _phoneNum, _password;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFieldName(text: 'Username'),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Username",
                  ),
                  validator: validateName,
                  //RequiredValidator(errorText: 'User Name is Required bro'),
                  onSaved: (username) => _username = username!,
                ),
                SizedBox(height: defaultPadding),
                TextFieldName(text: 'Email'),
                TextFormField(
                  validator: validateEmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Yesh@chala.com",
                  ),
                  //validator: EmailValidator(errorText: "Enter a valid email bro"),
                  onSaved: (email) => _email = email!,
                ),
                SizedBox(height: defaultPadding),
                TextFieldName(text: 'Phone'),
                TextFormField(
                  validator: validateMobile,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: "+1234567890",
                  ),
                  // validator:
                  // RequiredValidator(errorText: "Phone Number is Required bro"),
                  onSaved: (phone) => _phoneNum = phone!,
                ),
                SizedBox(height: defaultPadding),
                TextFieldName(text: 'Password'),
                TextFormField(
                  validator: validatePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "**********",
                  ),
                  // validator: passwordValidator,
                  onSaved: (password) => _password = password!,
                  //onChanged: (pass) => _password = pass,
                ),
                SizedBox(height: defaultPadding),
                TextFieldName(text: 'Confirm Password'),
                TextFormField(
                  // validator: (value) => validateConfirmPassword(
                  //     value, _password == null ? "" : _password),
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "**********",
                  ),
                  //validator: (pass) =>
                  //MatchValidator(errorText: "Passwords dont match")
                  //.validateMatch(pass!, _password)
                )
              ],
            )),
        SizedBox(height: defaultPadding * 2),
        StatefulBuilder(
            builder: (BuildContext context, StateSetter stateSetter) {
          bool _loading = false;
          return SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => GenDeetsScreen("123456634"),
                //     ));
                stateSetter(() {
                  _loading = true;
                });
                final form = formkey.currentState;
                if (form != null && form.validate()) {
                  form.save();
                  

                 
               Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GenDeetsScreen(_phoneNum,_email,_password,_username),
                      ));
                }},
           
              child: Text("Continue"),
            ),
          );
        }),
      ],
    );
  }
}


class TextFieldName extends StatelessWidget {
  const TextFieldName({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding / 3),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
      ),
    );
  }
}

class GenDeets extends StatelessWidget {
  GenDeets({
    Key? key,
    required this.formkey,
    required this.phoneNum,
    required this.email,
    required this.password,
    required this.username,
  }) : super(key: key);


  final GlobalKey<FormState> formkey;
  final String phoneNum,username,password,email;
  late String _medicalId,_hostpitalId,_specialization;


  @override
  Widget build(BuildContext context) {
    return Form(
        key: formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFieldName(text: 'Medical ID'),
            TextFormField(
              decoration: InputDecoration(
                hintText: "",
              ),
              onSaved: (val)=>_medicalId = val!,
            ),
            SizedBox(height: defaultPadding),
            TextFieldName(text: 'Hospital ID'),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(),
               onSaved: (val)=>_hostpitalId = val!,
            ),
            SizedBox(height: defaultPadding),
            TextFieldName(text: 'Specializations'),
            TextFormField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(),
              onSaved: (val)=>_specialization = val!,
            ),
              SizedBox(height: defaultPadding * 2),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                             final form = formkey.currentState;
                    if (form != null && form.validate()) {
                      form.save();
                      showLoaderDialog(context);
                      AuthServices()
                          .signUpWithEmailAndPassword(username,password,email,phoneNum,_medicalId,_hostpitalId,_specialization,(e) => toastMesssage(e))
                          .then((value) => {
                            print(value),
                            Navigator.pop(context),
                                  if(value)
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HomeScreen(),
                                        )),
                                    
                                    
                                  
                              }
                              );
                    }
                            },
                            child: Text("Create Account"),
                          ),
                        ),
          ],
        ));

        
  }
}
