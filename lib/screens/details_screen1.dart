
import 'package:doctor_consultation_app/components/schedule_card.dart';
import 'package:doctor_consultation_app/constant.dart';
import 'package:doctor_consultation_app/modules/consultations.dart';
import 'package:doctor_consultation_app/screens/loading_dailog.dart';
import 'package:doctor_consultation_app/services/consultations_services.dart';
import 'package:doctor_consultation_app/utils/errorCallback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';


class DetailScreen1 extends StatelessWidget {
  Consultation _consultation;

  DetailScreen1(this._consultation);

  @override
  Widget build(BuildContext context) {
    _consultation.records.map((element) => print(element.keys));
    List<String> recordNames = _consultation.records.first.keys.toList();
    List<List<String>> recordUrls = _consultation.records.first.values.toList();
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/detail_illustration.png'),
              alignment: Alignment.topCenter,
              fit: BoxFit.fitWidth,
            ),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                        'assets/icons/back.svg',
                        height: 18,
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/icons/3dots.svg',
                      height: 18,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.24,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Image.asset(
                            images[1],
                            height: 120,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                _consultation.docName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: kTitleTextColor,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                _consultation.appointmentName,
                                style: TextStyle(
                                  color: kTitleTextColor.withOpacity(0.7),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: <Widget>[
                                  InkWell(
                                    onTap: () async {
                                      showLoaderDialog(context);
                                      var url =
                                          'tel:${_consultation.docPhoneNumber}';
                                      if (await canLaunchUrlString(url)) {
                                        Navigator.pop(context);
                                        await launchUrlString(url);
                                      } else {
                                        Navigator.pop(context);
                                        toastMesssage(
                                          
                                            "Can't launch the Calling App.");
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: kBlueColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: SvgPicture.asset(
                                        'assets/icons/phone.svg',
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      showLoaderDialog(context);
                                      Uri smsUri = Uri(
                                        scheme: 'sms',
                                        path: '${_consultation.docPhoneNumber}',
                                      );

                                      Navigator.pop(context);
                                      await launchUrl(smsUri);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: kYellowColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: SvgPicture.asset(
                                        'assets/icons/Chat.svg',
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      showLoaderDialog(context);
                                      var url =
                                          'mailto:${_consultation.docEmail}';

                                      Navigator.pop(context);
                                      await launchUrlString(url);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: kYellowColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: SvgPicture.asset(
                                        'assets/icons/Mail.svg',color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        'General Notes',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: kTitleTextColor,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        _consultation.generalNotes,
                        style: TextStyle(
                          height: 1.6,
                          color: kTitleTextColor.withOpacity(0.7),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Your Records',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: kTitleTextColor,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        height: recordUrls.length * 100,
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () async {
                                showLoaderDialog(context);
                                print(recordUrls[index]);
                                await ConsultationServices()
                                    .downloadFileExample(recordUrls[index][0],recordUrls[index][1]);
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: ScheduleCard(
                                  recordNames[index],
                                  colors[index],
                                ),
                              ),
                            );
                          },
                          itemCount: recordNames.length,
                        ),
                      )

                     
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
