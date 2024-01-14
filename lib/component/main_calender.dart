import 'package:calender/const/color.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MainCalender extends StatelessWidget {
  final OnDaySelected onDaySelected;
  final DateTime? selectedDate;
  final DateTime focusedDate;
  const MainCalender(
      {super.key,
      required this.onDaySelected,
      required this.selectedDate,
      required this.focusedDate});

  @override
  Widget build(BuildContext context) {
    final defaultBoxDecoration = BoxDecoration(
        color: LIGHT_GRAY_COLOR,
        borderRadius: BorderRadius.circular(6.0),
        shape: BoxShape.rectangle);
    const outsiderDecoration = BoxDecoration(shape: BoxShape.rectangle);
    final defaultTextStyle =
        TextStyle(color: DARK_GRAY_COLOR, fontWeight: FontWeight.w700);

    return TableCalendar(
      locale: 'ja_JP',
      firstDay: DateTime(1800),
      lastDay: DateTime(2100),
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
      ),
      calendarStyle: CalendarStyle(
          isTodayHighlighted: false,
          defaultTextStyle: defaultTextStyle,
          defaultDecoration: defaultBoxDecoration,
          selectedDecoration: defaultBoxDecoration.copyWith(
            color: Colors.white,
            border: Border.all(width: 1.0, color: PRIMARY_COLOR),
          ),
          selectedTextStyle: defaultTextStyle.copyWith(color: PRIMARY_COLOR),
          weekendDecoration: defaultBoxDecoration,
          weekendTextStyle: defaultTextStyle,
          outsideDecoration: outsiderDecoration),
      focusedDay: focusedDate,
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
