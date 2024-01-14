import 'package:calender/const/color.dart';
import 'package:calender/database/schedule_with_color.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../database/drift_database.dart';

class TodayBanner extends StatelessWidget {
  final DateTime selectedDate;

  const TodayBanner({super.key, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    const textStyle =
        TextStyle(fontWeight: FontWeight.w700, color: Colors.white);
    return Container(
      color: PRIMARY_COLOR,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                "${selectedDate.year}年${selectedDate.month}月${selectedDate.day}日",
                style: textStyle),
            StreamBuilder<List<ScheduleWithColor>>(
                stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDate),
                builder: (context, snapshot) {
                  int count = 0;
                  if (snapshot.hasData) {
                    count = snapshot.data!.length;
                  }
                  return Text(count.toString(), style: textStyle);
                }),
          ],
        ),
      ),
    );
  }
}
