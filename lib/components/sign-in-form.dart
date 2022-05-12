
import 'package:doctor_consultation_app/constant.dart';
import 'package:doctor_consultation_app/screens/home_screen.dart';
import 'package:doctor_consultation_app/screens/loading_dailog.dart';
import 'package:doctor_consultation_app/services/auth_service.dart';
import 'package:doctor_consultation_app/utils/errorCallback.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';


class SignInForm extends StatefulWidget {
  SignInForm({
    Key? key,

  }) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  late String _email, _password;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: defaultPadding),
                TextFieldName(text: 'Email'),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Yesh@chala.com",
                  ),
                  validator: EmailValidator(errorText: "Enter a valid email bro"),
                  onSaved: (email) => _email = email!,
                ),
                SizedBox(height: defaultPadding),
                TextFieldName(text: 'Password'),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "**********",
                  ),
                 
                  onSaved: (password) => _password = password!,
                  onChanged: (pass) => _password = pass,
                ),
              ],
            )),
             SizedBox(height: defaultPadding * 2),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                formkey.currentState!.save();
                                showLoaderDialog(context);
                                AuthServices().signInWithEmailAndPassword(_email, _password, (e) {errorCallbackSignIn(e); }).then((value) {
                                    Navigator.pop(context);
                                    if(value)
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HomeScreen(),
                                        ));
                                });
                              }
                            },
                            child: Text("Sign Up"),
                          ),
                        ),
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
