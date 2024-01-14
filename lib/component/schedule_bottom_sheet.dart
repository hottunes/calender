import 'package:calender/component/custom_text_field.dart';
import 'package:calender/database/drift_database.dart';
import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../const/color.dart';

class ScheduleBottomSheet extends StatefulWidget {
  final DateTime selectedDate;
  final int? scheduleId;

  const ScheduleBottomSheet(
      {super.key, required this.selectedDate, this.scheduleId});

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();

  int? startTime;
  int? endTime;
  String? content;
  int? selectedColorId;

  @override
  Widget build(BuildContext context) {
    final bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: FutureBuilder<Object>(
          future: null,
          builder: (context, snapshot) {
            return FutureBuilder<Schedule>(
                future: widget.scheduleId == null
                    ? null
                    : GetIt.I<LocalDatabase>()
                        .getScheduleById(widget.scheduleId!),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text("スケジュルの取得してに失敗しました"));
                  }
                  // Initialize FutureBuilder and on Loading...
                  if (snapshot.connectionState != ConnectionState.none &&
                      !snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  //Future is ready. have values but no data for startTime.
                  if (snapshot.hasData && startTime == null) {
                    startTime = snapshot.data!.startTime;
                    endTime = snapshot.data!.endTime;
                    content = snapshot.data!.content;
                    selectedColorId = snapshot.data!.colorId;
                  }
                  return Container(
                    color: Colors.white,
                    child: SafeArea(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 2 +
                            bottomInsets,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: bottomInsets),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, right: 16.0, top: 8.0),
                            child: Form(
                              // like controller
                              key: formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _Time(
                                    onStartSaved: (String? newValue) {
                                      startTime = int.parse(newValue!);
                                    },
                                    onEndSaved: (String? newValue) {
                                      endTime = int.parse(newValue!);
                                    },
                                    startInitialValue:
                                        startTime?.toString() ?? '',
                                    endInitialValue:
                                        startTime?.toString() ?? '',
                                  ),
                                  const SizedBox(height: 16),
                                  _Content(
                                    onSaved: (String? newValue) {
                                      content = newValue;
                                    },
                                    initialValue: content ?? '',
                                  ),
                                  const SizedBox(height: 16),
                                  FutureBuilder<List<CategoryColor>>(
                                      future: GetIt.I<LocalDatabase>()
                                          .getCategoryColors(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData &&
                                            selectedColorId == null &&
                                            snapshot.data!.isNotEmpty) {
                                          selectedColorId =
                                              snapshot.data![0].id;
                                        }
                                        return _ColorPicker(
                                          colors: snapshot.hasData
                                              ? snapshot.data!
                                              : [],
                                          selectedColorId: selectedColorId,
                                          colorIdSetter: (int id) {
                                            setState(() {
                                              selectedColorId = id;
                                            });
                                          },
                                        );
                                      }),
                                  const SizedBox(height: 8),
                                  _SaveButton(
                                    onPressed: onSaveButtonPressed,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }),
    );
  }

  void onSaveButtonPressed() async {
    if (formKey.currentState == null) return;
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (widget.scheduleId == null) {
        await GetIt.I<LocalDatabase>().createSchedule(
          SchedulesCompanion(
            date: Value(widget.selectedDate),
            startTime: Value(startTime!),
            endTime: Value(endTime!),
            content: Value(content!),
            colorId: Value(selectedColorId!),
          ),
        );
      } else {
        await GetIt.I<LocalDatabase>().updateScheduleByID(
          widget.scheduleId!,
          SchedulesCompanion(
            date: Value(widget.selectedDate),
            startTime: Value(startTime!),
            endTime: Value(endTime!),
            content: Value(content!),
            colorId: Value(selectedColorId!),
          ),
        );
      }

      Navigator.of(context).pop();
    } else {}
  }
}

class _Time extends StatelessWidget {
  final FormFieldSetter<String> onStartSaved;
  final FormFieldSetter<String> onEndSaved;
  final String startInitialValue;
  final String endInitialValue;

  const _Time(
      {required this.onStartSaved,
      required this.onEndSaved,
      required this.startInitialValue,
      required this.endInitialValue});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: MyTextField(
          label: '開始時間',
          isTime: true,
          onSaved: onStartSaved,
          initialValue: startInitialValue,
        )),
        const SizedBox(width: 10),
        Expanded(
            child: MyTextField(
          isTime: true,
          label: '終了時間',
          onSaved: onEndSaved,
          initialValue: endInitialValue,
        ))
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final FormFieldSetter<String> onSaved;
  final String initialValue;

  const _Content({required this.onSaved, required this.initialValue});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: MyTextField(
      label: '内容',
      isTime: false,
      onSaved: onSaved,
      initialValue: '',
    ));
  }
}

typedef ColorIdSetter = void Function(int id);

class _ColorPicker extends StatelessWidget {
  final List<CategoryColor> colors;
  final int? selectedColorId;
  final ColorIdSetter colorIdSetter;

  const _ColorPicker(
      {required this.colors,
      required this.selectedColorId,
      required this.colorIdSetter});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: colors
          .map((e) => GestureDetector(
                onTap: () {
                  colorIdSetter(e.id);
                },
                child: renderColor(e, selectedColorId == e.id),
              ))
          .toList(),
    );
  }

  Container renderColor(CategoryColor color, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(int.parse('FF${color.hexCode}', radix: 16)),
          border:
              isSelected ? Border.all(color: Colors.black, width: 4.0) : null),
      width: 40,
      height: 40,
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _SaveButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: PRIMARY_COLOR, foregroundColor: Colors.white),
        onPressed: onPressed,
        child: const Row(
          children: [
            Expanded(child: Text("保存")),
          ],
        ));
  }
}
