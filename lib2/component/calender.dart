import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../const/color.dart';

class Calender extends StatelessWidget {
  final DateTime? selectedDate;
  final DateTime focusedDay;
  final OnDaySelected? onDaySelected;

  const Calender(
      {super.key,
      required this.selectedDate,
      required this.focusedDay,
      required this.onDaySelected});

  @override
  Widget build(BuildContext context) {
    final defaultBoxDecoration = BoxDecoration(
      color: Colors.grey[200],
      borderRadius: const BorderRadius.all(Radius.circular(6.0)),
    );
    final defaultTestStyle =
        TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w700);
    return TableCalendar(
      locale: 'ko_KR',
      focusedDay: focusedDay,
      firstDay: DateTime(1800),
      lastDay: DateTime(2100),
      headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle:
              TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0)),
      calendarStyle: CalendarStyle(
        isTodayHighlighted: false,
        defaultDecoration: defaultBoxDecoration,
        weekendDecoration: defaultBoxDecoration,
        selectedDecoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(
              color: PRIMARY_COLOR,
              width: 1.0,
            )),
        outsideDecoration: const BoxDecoration(shape: BoxShape.rectangle),
        defaultTextStyle: defaultTestStyle,
        weekendTextStyle: defaultTestStyle,
        selectedTextStyle: defaultTestStyle.copyWith(color: PRIMARY_COLOR),
      ),
      onDaySelected: onDaySelected,
      selectedDayPredicate: (DateTime date) {
        if (selectedDate == null) return false;
        return date.year == selectedDate!.year &&
            date.month == selectedDate!.month &&
            date.day == selectedDate!.day;
      },
    );
  }
}
