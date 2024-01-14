import 'package:calender/const/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTestField extends StatelessWidget {
  const CustomTestField({super.key, required this.label, required this.isTime});

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

  TextFormField renderTextField() {
    return TextFormField(
      // null return 되면 에러가 없다
      // 에러가 있으면 에러를 String 값으로 리턴.
      validator: (String? value) {
        return 'ErrorTest';
      },
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
