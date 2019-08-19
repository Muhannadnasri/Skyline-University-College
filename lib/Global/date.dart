import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ComplexDateTimeField extends StatefulWidget {
  @override
  _ComplexDateTimeFieldState createState() => _ComplexDateTimeFieldState();
}

class _ComplexDateTimeFieldState extends State<ComplexDateTimeField> {
  final format = DateFormat("yyyy-MM-dd HH:mm");
  final initialValue = DateTime.now();

  bool autoValidate = false;
  bool readOnly = true;
  bool showResetIcon = true;
  DateTime value = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Complex date & time field (${format.pattern})'),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
          if (date != null) {
            final time = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );
            return DateTimeField.combine(date, time);
          } else {
            return currentValue;
          }
        },
        autovalidate: autoValidate,
        validator: (date) => date == null ? 'Invalid date' : null,
        initialValue: initialValue,
        resetIcon: showResetIcon ? Icon(Icons.delete) : null,
        readOnly: readOnly,
      ),
    ]);
  }
}
