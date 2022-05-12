import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_consultation_app/modules/patients.dart';
import 'package:doctor_consultation_app/services/notification.dart';
import 'package:doctor_consultation_app/services/patients_services.dart';
import 'package:doctor_consultation_app/utils/errorCallback.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../components/search-result-card.dart';
import '../components/search_bar.dart';
import '../constant.dart';

class SearchResults extends StatefulWidget {
  SearchResults({key, required this.search}) : super(key: key);
  String search;

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  List<Patient> _patients = [];
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot>(
            stream: PatientServices().userProfileStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Patient> _patientList =
                    snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;

                  return Patient.fromJson(data);
                }).toList();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Stack(
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
                                controller:
                                    TextEditingController(text: widget.search),
                                onChanged: ((value) => {
                                      setState(() {
                                        //widget.search = value;
                                        _patients = _patientList
                                            .where((element) => element.userName
                                                .toLowerCase()
                                                .contains(value.toLowerCase()))
                                            .toList();
                                        print(_patients.length);
                                        print(_patientList.length);
                                      })
                                    }),
                                decoration: InputDecoration.collapsed(
                                  hintText: 'Search ',
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: MaterialButton(
                              onPressed: () {},
                              color: kOrangeColor,
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 15,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child:
                                  SvgPicture.asset('assets/icons/search.svg'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        'Results for ' +
                            FirebaseAuth.instance.currentUser!.displayName!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: kTitleTextColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    StreamBuilder<QuerySnapshot>(
                        stream: NotificationServices().getUserNotifications(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<Map<String, dynamic>> _notifications = snapshot
                                .data!.docs
                                .map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data()! as Map<String, dynamic>;

                              return data;
                            }).toList();

                            return SizedBox(
                              height: queryData.size.height * 0.8,
                              child: _patients.length == 0
                                  ? Center(
                                      child: SizedBox(
                                          child: Text(
                                        "No patients Found.",
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 24),
                                      )),
                                    )
                                  : ListView.builder(
                                      itemBuilder: (context, index) {
                                        String status = '';
                                        try {
                                          var list = _notifications.length != 0
                                              ? _notifications.firstWhere(
                                                  (element) =>
                                                      element['userId'] ==
                                                      _patients[index].userId,
                                                  orElse: null)
                                              : null;

                                          print(list);
                                          //print("lsit"+list['docId']);
                                          if (list == null) {
                                            status = "false";
                                          } else {
                                            status = list['approved'] == true
                                                ? "approved"
                                                : "waiting";
                                          }
                                        } catch (e) {
                                          status = "false";
                                        }

                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SerResCard1(
                                              _patients[index].userName,
                                              "",
                                              images[1],
                                              colors[1], () {
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: Text(
                                                    "Requesting Medical Records Access"),
                                                content: Text(
                                                    "Please click yes to continue"),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('Cancel'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () async {
                                                      print("yes");
                                                      bool flag =
                                                          await NotificationServices()
                                                              .setNotification(
                                                                  _patients[
                                                                          index]
                                                                      .userId,
                                                                  _patients[
                                                                          index]
                                                                      .userName,
                                                                  (e) {
                                                        toastMesssage(e);
                                                      });
                                                      print("flag" +
                                                          flag.toString());
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('Yes'),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }, status, _patients[index].userId),
                                        );
                                      },
                                      itemCount: _patients.length,
                                    ),
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return Center(
                                child:
                                    Text("Something Went Wrong. LTry Again"));
                          }
                        }),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: [],
                      ),
                    )
                  ],
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return buildConnectionWaiting(context);
              } else {
                return buildError(context);
              }
            },
          ),
        ),
      ),
    );
  }

  Column buildError(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Stack(
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
                    controller: TextEditingController(text: widget.search),
                    // onChanged: ((value) => search = value),
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
                  onPressed: () {},
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
        SizedBox(height: 20),
        Text("Something Went Wrong.Try Again")
      ],
    );
  }

  Column buildConnectionWaiting(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Stack(
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
                    controller: TextEditingController(text: widget.search),
                    //  onChanged: ((value) => search = value),
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
                  onPressed: () {},
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
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            'Results for Yesh Chala ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: kTitleTextColor,
              fontSize: 16,
            ),
          ),
        ),
        SizedBox(height: 15),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: CircularProgressIndicator(),
        )
      ],
    );
  }
}
