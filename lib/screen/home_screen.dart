import 'package:calender/component/main_calender.dart';
import 'package:calender/component/schedule_bottom_sheet.dart';
import 'package:calender/database/drift_database.dart';
import 'package:calender/database/schedule_with_color.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../component/schedule_card.dart';
import '../component/today_banner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime focusedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: renderFloatingButton(),
      body: SafeArea(
        child: Column(
          children: [
            MainCalender(
              onDaySelected: onDaySelected,
              selectedDate: selectedDate,
              focusedDate: focusedDate,
            ),
            const SizedBox(height: 8.0),
            TodayBanner(
              selectedDate: selectedDate,
            ),
            const SizedBox(height: 8.0),
            _ScheduleList(
              selectedDate: selectedDate,
            ),
          ],
        ),
      ),
    );
  }

  FloatingActionButton renderFloatingButton() {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (_) => ScheduleBottomSheet(
                  selectedDate: selectedDate,
                ));
      },
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    );
  }

  void onDaySelected(DateTime selectedDate, DateTime focusedDate) {
    setState(() {
      this.selectedDate = selectedDate;
      this.focusedDate = selectedDate;
    });
  }
}

class _ScheduleList extends StatelessWidget {
  final DateTime selectedDate;

  const _ScheduleList({required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: StreamBuilder<List<ScheduleWithColor>>(
            stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDate),
            builder: (context, snapshot) {
              print(snapshot.data);
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData && snapshot.data!.isEmpty) {
                return const Center(child: Text('No Schedule'));
              }
              return ListView.separated(
                  itemCount: snapshot.data!.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8.0),
                  itemBuilder: (context, index) {
                    final scheduleWithColor = snapshot.data![index];
                    return Dismissible(
                      key: ObjectKey(scheduleWithColor.schedule.id),
                      direction: DismissDirection.endToStart,
                      onDismissed: (DismissDirection direction) {
                        GetIt.I<LocalDatabase>()
                            .removeSchedule(scheduleWithColor.schedule.id);
                      },
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (_) => ScheduleBottomSheet(
                                    selectedDate: selectedDate,
                                    scheduleId: scheduleWithColor.schedule.id,
                                  ));
                        },
                        child: ScheduleCard(
                            startTime: scheduleWithColor.schedule.startTime,
                            endTime: scheduleWithColor.schedule.endTime,
                            content: scheduleWithColor.schedule.content,
                            color: Color(int.parse(
                                'FF${scheduleWithColor.categoryColor.hexCode}',
                                radix: 16))),
                      ),
                    );
                  });
            }),
      ),
    );
  }
}
