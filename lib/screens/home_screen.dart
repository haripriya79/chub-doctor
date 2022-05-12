import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_consultation_app/components/category_card.dart';
import 'package:doctor_consultation_app/components/doctor_card.dart';
import 'package:doctor_consultation_app/components/search_bar.dart';
import 'package:doctor_consultation_app/constant.dart';
import 'package:doctor_consultation_app/modules/consultations.dart';
import 'package:doctor_consultation_app/screens/detail_screen.dart';
import 'package:doctor_consultation_app/screens/details_screen1.dart';
import 'package:doctor_consultation_app/screens/search-results.dart';
import 'package:doctor_consultation_app/services/consultations_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../profile/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  String search = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SvgPicture.asset('assets/icons/menu.svg'),
                    IconButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(),
                        ),
                      ),
                      icon: SvgPicture.asset('assets/icons/profile.svg'),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Welcome Dr.Yesh Chala',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    color: kTitleTextColor,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child:Stack(
      children: <Widget>[
        Container(
          height: 45,
          width: MediaQuery.of(context).size.width * 0.7,
          padding: EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            color: kSearchBackgroundColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: TextField(
              onChanged: ((value) => search =value),
              textAlign: TextAlign.center,
              decoration: InputDecoration.collapsed(
                hintText: 'Search ',
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: MaterialButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchResults(search: search),
                ),
              );
            },
            color: kOrangeColor,
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 15,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: SvgPicture.asset('assets/icons/search.svg'),
          ),
        ),
      ],
    ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Your Recent Consultations. ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kTitleTextColor,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              buildDoctorList(context),
            ],
          ),
        ),
      ),
    );
  }

  buildDoctorList(queryData) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: StreamBuilder<QuerySnapshot>(
          stream: ConsultationServices().getDoctorConsultations(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Consultation> _consultation =
                  snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;

                return Consultation.fromJson(data);
              }).toList();
              return _consultation.length !=0 ? SizedBox(
                height: _consultation.length * 120,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: DoctorCard2(
                          _consultation[index].appointmentName,
                          _consultation[index].appointmentDate,
                          _consultation[index].docName,
                          images[index],
                          colors[index], () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailScreen1(_consultation[index]),
                          ),
                        );
                      }),
                    );
                  },
                  itemCount:
                      _consultation.length > 3 ? 3 : _consultation.length,
                ),
              ): Center(
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    children: [

                      SizedBox(child: Text("You don't have any consultations yet",style: TextStyle(color: Colors.black54,fontSize: 18,),textAlign: TextAlign.center,),),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical:8.0),
                        child: ElevatedButton(onPressed: (){Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchResults(search: ""),
                ),
              );}, child: Text("Add Consultations",style: TextStyle(color: Colors.white,fontSize: 18),)),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }
          }),
    );
  }
}
