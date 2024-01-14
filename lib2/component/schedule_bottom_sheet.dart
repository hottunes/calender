import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../const/color.dart';

class ScheduleBottomSheet extends StatefulWidget {
  const ScheduleBottomSheet({super.key});

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5 + bottomInsets,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomInsets),
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 16),
              child: Form(
                child: Column(
                  key: formKey,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Time(),
                    const SizedBox(height: 16),
                    _Content(),
                    const SizedBox(height: 16),
                    _ColorPicker(),
                    const SizedBox(height: 8),
                    _SaveButton(
                      onPressed: onSavePressed,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onSavePressed() {
    // formKey 생성을 했는데 Form 위젯과 결합을 안 했을 때
    if (formKey.currentState == null) return;
    if (formKey.currentState!.validate()) {
      print('no error');
    } else {
      print('error');
    }
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
        SizedBox(width: 16),
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
      runSpacing: 10,
      children: [
        renderColor(Colors.red),
        renderColor(Colors.orange),
        renderColor(Colors.yellow),
        renderColor(Colors.green),
        renderColor(Colors.blue),
        renderColor(Colors.indigo),
        renderColor(Colors.purple),
      ],
    );
  }

  Widget renderColor(Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      width: 32,
      height: 32,
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.label, required this.isTime});

  final String label;
  final bool isTime;

  @override
  Widget build(BuildContext context) {
    const textStyle =
        TextStyle(color: PRIMARY_COLOR, fontWeight: FontWeight.w600);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: textStyle),
        if (isTime) renderTextField(),
        if (!isTime) Expanded(child: renderTextField())
      ],
    );
  }

  TextField renderTextField() {
    return TextField(
      cursorColor: Colors.grey,
      maxLines: isTime ? 1 : null,
      expands: !isTime,
      keyboardType: isTime ? TextInputType.number : TextInputType.multiline,
      inputFormatters: isTime ? [FilteringTextInputFormatter.digitsOnly] : [],
      decoration: InputDecoration(
          border: InputBorder.none, filled: true, fillColor: Colors.grey[300]),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _SaveButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
                backgroundColor: PRIMARY_COLOR,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4))),
            child: const Text(
              '保存',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
