import 'package:calender/const/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isTime;
  const CustomTextField({super.key, required this.label, required this.isTime});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              color: PRIMARY_COLOR, fontWeight: FontWeight.w600),
        ),
        if (isTime) renderTextField(),
        if (!isTime) Expanded(child: renderTextField()),
      ],
    );
  }

  TextField renderTextField() {
    return TextField(
      expands: !isTime,
      keyboardType: isTime ? TextInputType.number : TextInputType.multiline,
      maxLines: isTime ? 1 : null,
      cursorColor: Colors.grey,
      inputFormatters: isTime ? [FilteringTextInputFormatter.digitsOnly] : [],
      decoration: InputDecoration(
          border: InputBorder.none, filled: true, fillColor: Colors.grey[300]),
    );
  }
}
