import 'dart:io';

import 'package:doctor_consultation_app/screens/home_screen.dart';
import 'package:doctor_consultation_app/screens/loading_dailog.dart';
import 'package:doctor_consultation_app/services/consultations_services.dart';
import 'package:doctor_consultation_app/utils/errorCallback.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constant.dart';
import '/components/sign-in-form.dart';

class AddRecs extends StatelessWidget {
  AddRecs({required this.userId});
  late String _name ,_cause ,_date, _notes;
  String userId;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Records'),
      ),
      resizeToAvoidBottomInset: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding:  
                      const EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Add Consultation",
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: defaultPadding),
                              TextFieldName(text: 'Consultation Name'),
                              TextFormField(
                                onSaved: ((newValue) => _name = newValue!),
                               
                                decoration: InputDecoration(),
                              ),
                              SizedBox(height: defaultPadding),
                              TextFieldName(text: 'Cause of Consultation'),
                              TextFormField(
                                onSaved: ((newValue) => _cause = newValue!),
                                decoration: InputDecoration(),
                              ),
                              SizedBox(height: defaultPadding),
                              TextFieldName(text: 'Observations / Notes'),
                              TextFormField(
                                onSaved: ((newValue) => _notes = newValue!),
                                decoration: InputDecoration(),
                              ),
                              SizedBox(height: defaultPadding),
                              TextFieldName(text: 'Consultation Date'),
                              TextFormField(
                                onSaved: ((newValue) => _date = newValue!),
                                decoration: InputDecoration(),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: defaultPadding * 2),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                                if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                               
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddRecords(cause: _cause, date: _date, name: _name, notes: _notes,userId: userId),
                                ),
                              );
                                }
                            },
                            child: Text("Continue"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddRecords extends StatefulWidget {
  AddRecords({required this.cause,required this.date,required this.name,required this.notes,required this.userId});
   String name ,cause ,date, notes,userId;
  

  @override
  State<AddRecords> createState() => _AddRecordsState();
}

class _AddRecordsState extends State<AddRecords> {
   File? file;
   String? fileName;
     void _pickFile() async {
    // opens storage to pick files and the picked file or files
    // are assigned into result and if no file is chosen result is null.
    // you can also toggle "allowMultiple" true or false depending on your need
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    // if no file is picked
    if (result == null ) return;

    // we get the file from result object
    if(result.files.first.path==null) return;
     
    setState(() {
      file = File(result.files.first.path!);
    fileName = result.files.first.name;
   
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Records'),
      ),
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Upload Records",
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: defaultPadding),
                            ProfileMenu2(
                              text: "Blood Report",
                              press: () {
                                _pickFile();
                              },
                            ),
                            SizedBox(height: defaultPadding),
                            ProfileMenu2(
                              text: "Sugar Report",
                              press: () {},
                            ),
                            SizedBox(height: defaultPadding),
                            ProfileMenu2(
                              text: "X-Ray",
                              press: () {},
                            ),
                            SizedBox(height: defaultPadding),
                            ProfileMenu2(
                              text: "MRI",
                              press: () {},
                            ),
                            SizedBox(height: defaultPadding),
                            ProfileMenu2(
                              text: "Medical Prescription",
                              press: () {},
                            ),
                          ],
                        ),
                        SizedBox(height: defaultPadding * 2),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: ()async {
                              ConsultationServices().setDoctorConsultations((e)=>toastMesssage(e), widget.userId,widget.name,widget.notes, file!, fileName!).then((value) => {
Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
                              )
                              });

                              
                            },
                            child: Text("Upload"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileMenu2 extends StatelessWidget {
  const ProfileMenu2({
    Key? key,
    required this.text,
    this.press,
  }) : super(key: key);

  final String text;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          TextButton(
            style: TextButton.styleFrom(
              elevation: 10,
              primary: Color(0xFF255ED6),
              padding: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              backgroundColor: Color(0xFFF5F6F9),
            ),
            onPressed: press,
            child: Row(
              children: [
                SizedBox(width: 20),
                Expanded(child: Text(text)),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: "Any Remarks",
            ),
          ),
        ],
      ),
    );
  }
}
