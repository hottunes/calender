import 'package:calender/const/color.dart';
import 'package:flutter/material.dart';

import 'custom_text_field2.dart';

class ScheduleBottomSheet extends StatelessWidget {
  const ScheduleBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height / 2 + bottomInsets,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomInsets),
            child: Padding(
              padding: EdgeInsets.only(left: 8, right: 8, top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Time(),
                  SizedBox(height: 16),
                  _Content(),
                  SizedBox(height: 16),
                  _ColorPicker(),
                  SizedBox(height: 8),
                  _SaveButton(),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Time extends StatelessWidget {
  const _Time();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
            child: CustomTextField(
          label: '開始時間',
          isTime: true,
        )),
        SizedBox(width: 8.0),
        Expanded(
            child: CustomTextField(
          label: '終了時間',
          isTime: true,
        )),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: CustomTextField(
        label: '内容',
        isTime: false,
      ),
    );
  }
}

class _ColorPicker extends StatelessWidget {
  const _ColorPicker();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 10.0,
      children: [
        renderColor(Colors.red),
        renderColor(Colors.orange),
        renderColor(Colors.yellow),
        renderColor(Colors.green),
        renderColor(Colors.teal),
        renderColor(Colors.blue),
        renderColor(Colors.indigo),
      ],
    );
  }

  Container renderColor(Color color) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      width: 32,
      height: 32,
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: PRIMARY_COLOR,
                    foregroundColor: Colors.white),
                child: const Text('保存'))),
      ],
    );
  }
}
