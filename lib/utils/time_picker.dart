import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget TimePicker(property, labelText) {
  TimeOfDay guardedTime = guarded(property);

  return  Expanded(
      child: DateTimePickerFormField(
        inputType: InputType.time,
        format: DateFormat("HH:mm"),
        initialValue: DateTime(
            0,
            0,
            0,
          guardedTime.hour,
          guardedTime.minute),
        initialTime: TimeOfDay(
            hour: guardedTime.hour,
            minute: guardedTime.minute),
        editable: false,
        decoration: InputDecoration(
            labelText: labelText,
            hasFloatingPlaceholder: true),
        onChanged: (timeSelected) {
          property = TimeOfDay(
              hour: guardedTime.hour,
              minute: guardedTime.minute);
        },
      ),
    );
}

TimeOfDay guarded(value) {
  if (value == null) {
    return TimeOfDay(hour: 0, minute: 0);
  } else {
    return value;
  }
}