import 'package:calender/component/today_banner.dart';
import 'package:flutter/material.dart';

import '../component/schedule_bottom_sheet.dart';
import '../component/schedule_card.dart';
import '../const/color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: renderFloatingButton(),
      body: SafeArea(
        child: Column(
          children: [
            Calender(
              focusedDay: focusedDay,
              onDaySelected: onDaySelected,
              selectedDate: selectedDay,
            ),
            const SizedBox(height: 8),
            TodayBanner(selectedDate: selectedDay, scheduleCount: 3),
            const SizedBox(height: 10),
            const _ScheduleList(),
          ],
        ),
      ),
    );
  }

  void onDaySelected(
    DateTime selectedDay,
    DateTime focusedDay,
  ) {
    setState(() {
      this.selectedDay = selectedDay;
      this.focusedDay = selectedDay;
    });
  }

  FloatingActionButton renderFloatingButton() {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) {
              return const ScheduleBottomSheet();
            });
      },
      backgroundColor: PRIMARY_COLOR,
      child: const Icon(Icons.add, color: Colors.white),
    );
  }
}

class _ScheduleList extends StatelessWidget {
  const _ScheduleList();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemCount: 5,
            itemBuilder: (context, index) => const ScheduleCard(
                startTime: 8,
                endTime: 9,
                content: 'content',
                color: Colors.red)),
      ),
    );
  }
}
