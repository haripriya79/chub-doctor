import 'package:doctor_consultation_app/constant.dart';
import 'package:flutter/material.dart';

class ScheduleCard extends StatelessWidget {
  var _title;
  var _description;
  var _date;
  var _month;
  var _bgColor;

  ScheduleCard(this._title, this._bgColor);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: _bgColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: ListTile(
          title: Text(
            _title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: kTitleTextColor,
            ),
          ),
        ),
      ),
    );
  }
}
