import 'package:calender/const/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatelessWidget {
  final bool isTime;
  final String label;
  final FormFieldSetter<String> onSaved;
  final String initialValue;

  const MyTextField(
      {super.key,
      required this.isTime,
      required this.label,
      required this.onSaved,
      required this.initialValue});

  @override
  Widget build(BuildContext context) {
    const textStyle =
        TextStyle(color: PRIMARY_COLOR, fontWeight: FontWeight.w600);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: textStyle),
        if (isTime) renderTextField(),
        if (!isTime) Expanded(child: renderTextField()),
      ],
    );
  }

  Widget renderTextField() {
    return TextFormField(
        onSaved: onSaved,
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a value';
          }
          if (isTime) {
            int time = int.parse(value);
            if (time < 0) {
              return 'please enter a valid tim e';
            }
            if (time > 24) {
              return 'please enter a valid time';
            }
          }
          return null;
        },
        maxLines: isTime ? 1 : null,
        keyboardType: isTime ? TextInputType.number : TextInputType.multiline,
        expands: !isTime,
        initialValue: initialValue,
        inputFormatters: isTime ? [FilteringTextInputFormatter.digitsOnly] : [],
        cursorColor: Colors.grey,
        decoration: InputDecoration(
            suffixText: isTime ? '時' : null,
            fillColor: Colors.grey[300],
            border: InputBorder.none,
            filled: true));
  }
}
