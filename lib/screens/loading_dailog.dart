import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text("Loading..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }
  showQrCodeDialog(BuildContext context){
    User user= FirebaseAuth.instance.currentUser!;
    AlertDialog alert=AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("QR Code"),
          Align(alignment: Alignment.centerRight,child: IconButton(icon: Icon(Icons.close),onPressed: (){
            Navigator.pop(context);
          },),),
        ],
      ),
      insetPadding: EdgeInsets.all(0),
      contentPadding: EdgeInsets.all(10),
      titlePadding: EdgeInsets.all(10),
      content: SizedBox(
        height: 300,
        width: 300,
        child: 
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  QrImage(data: user.uid),
                ],
              ),
             
              //Container(margin: EdgeInsets.only(left: 7),child:Text("" )),
          
        
      ),
    );
    showDialog(
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }