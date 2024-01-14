import 'package:flutter/material.dart';

import '../const/color.dart';

class TodayBanner extends StatelessWidget {
  final DateTime selectedDate;
  final int scheduleCount;
  const TodayBanner(
      {super.key, required this.selectedDate, required this.scheduleCount});

  @override
  Widget build(BuildContext context) {
    const textStyle =
        TextStyle(fontWeight: FontWeight.w600, color: Colors.white);
    return Container(
      color: PRIMARY_COLOR,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${selectedDate.year}年${selectedDate.month}月${selectedDate.day}日',
              style: textStyle,
            ),
            Text(
              '$scheduleCount',
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}
