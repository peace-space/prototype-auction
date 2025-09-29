import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:prototype_your_auction_services/screen/AuctionHome.dart';

import '../../admin/screen_admin/user_auction_list_admin_widget.dart';

Widget countDownList(BuildContext context, end_date_time_data) {
  // final end_date_time_data ;
  var end_date_time = DateTime.parse(end_date_time_data);
  var date_tiem_difference = end_date_time.difference(DateTime.now());
  // return TimerCountdown(endTime: DateTime.now());
  // return Text("data");
  if (date_tiem_difference <= Duration.zero) {
    return Text("หมดเวลา", style: TextStyle(color: Colors.red, fontSize: 13));
  }
  return TimerCountdown(
    endTime: DateTime.now().add(
      Duration(seconds: date_tiem_difference.inSeconds),
    ),
    onTick: (remainingTime) {},
    format: CountDownTimerFormat.daysHoursMinutesSeconds,
    enableDescriptions: false,
    spacerWidth: 1,
    timeTextStyle: TextStyle(fontSize: 13, color: Colors.red, height: 0),
    daysDescription: "day",
    hoursDescription: "hour",
    minutesDescription: "min",
    secondsDescription: "sec",
    descriptionTextStyle: TextStyle(height: 0),
    colonsTextStyle: TextStyle(fontSize: 13, color: Colors.red),
    onEnd: () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuctionHome()),
      );
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('หมดเวลา'),
          content: Text("สามารถตรวจสอบผลการประมูล"),
          actions: [
            TextButton(
              onPressed: () => {Navigator.of(context).pop()},
              child: Text('ตกลง'),
            ),
          ],
        ),
      );
    },
  );
}

Widget countDownDetail(BuildContext context, var end_date_time_data) {
  // final end_date_time_data = detailAuctionData['end_date_time'];
  var end_date_time = DateTime.parse(end_date_time_data);

  var date_tiem_difference = end_date_time.difference(DateTime.now());

  if (date_tiem_difference <= Duration.zero) {
    return Text("หมดเวลา", style: TextStyle(color: Colors.red, fontSize: 21));
  }

  var countdown = TimerCountdown(
    endTime: DateTime.now().add(
      Duration(seconds: date_tiem_difference.inSeconds),
    ),
    onTick: (remainingTime) {},
    format: CountDownTimerFormat.daysHoursMinutesSeconds,
    enableDescriptions: true,
    spacerWidth: 5,
    timeTextStyle: TextStyle(fontSize: 21, color: Colors.red, height: 0),
    daysDescription: "day",
    hoursDescription: "hour",
    minutesDescription: "min",
    secondsDescription: "sec",
    descriptionTextStyle: TextStyle(height: 0),
    colonsTextStyle: TextStyle(fontSize: 21, color: Colors.red),
    onEnd: () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuctionHome()),
      );
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('หมดเวลา'),
          content: Text("สามารถตรวจสอบผลการประมูล"),
          actions: [
            TextButton(
              onPressed: () => {Navigator.of(context).pop()},
              child: Text('ตกลง'),
            ),
          ],
        ),
      );
    },
  );

  return countdown;
}
