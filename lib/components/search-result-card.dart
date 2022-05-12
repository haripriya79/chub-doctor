import 'package:doctor_consultation_app/constant.dart';
import 'package:doctor_consultation_app/screens/detail_screen.dart';
import 'package:doctor_consultation_app/screens/detail_screen2.dart';
import 'package:doctor_consultation_app/screens/details_screen1.dart';
import 'package:doctor_consultation_app/screens/patient-screen.dart';
import 'package:flutter/material.dart';

class SerResCard extends StatelessWidget {
  var _name;
  var _description;
  var _imageUrl;
  var _bgColor;


  SerResCard(this._name, this._description, this._imageUrl, this._bgColor);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PatientScreen(_name, _description, _imageUrl),
          ),
        );
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: _bgColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListTile(
            leading: Image.asset(_imageUrl),
            title: Text(
              _name,
              style: TextStyle(
                color: kTitleTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              _description,
              style: TextStyle(
                color: kTitleTextColor.withOpacity(0.7),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
  class SerResCard1 extends StatelessWidget {
  var _name;
  var _description;
  var _imageUrl;
  var _bgColor;
  Function _funciton;
  String status;
  String userId;

  

  SerResCard1(this._name, this._description, this._imageUrl, this._bgColor,this._funciton,this.status,this.userId);

  @override
  Widget build(BuildContext context) {
    if(status == "waiting"){
       return InkWell(
      
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: _bgColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListTile(
            trailing:
             Text("Requested Access",style:TextStyle(color: Colors.blue) ),
            leading: Image.asset(_imageUrl),
            title: Text(
              _name,
              style: TextStyle(
                color: kTitleTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              _description,
              style: TextStyle(
                color: kTitleTextColor.withOpacity(0.7),
              ),
            ),
          ),
        ),
      ),
    );
  
    }else if(status == "approved"){
      return InkWell(
      
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: _bgColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListTile(
           onTap: (){
                Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailScreen2(userId),
                                ),
                              );
           },
            leading: Image.asset(_imageUrl),
            title: Text(
              _name,
              style: TextStyle(
                color: kTitleTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              _description,
              style: TextStyle(
                color: kTitleTextColor.withOpacity(0.7),
              ),
            ),
          ),
        ),
      ),
    );
  

    }
    return InkWell(
      
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: _bgColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListTile(
            trailing:
             ElevatedButton(child: Text("Request Access"),onPressed: (){
              _funciton();
            },),
            leading: Image.asset(_imageUrl),
            title: Text(
              _name,
              style: TextStyle(
                color: kTitleTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              _description,
              style: TextStyle(
                color: kTitleTextColor.withOpacity(0.7),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
