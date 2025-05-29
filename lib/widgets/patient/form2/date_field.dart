import 'package:flutter/material.dart';

class DateField extends StatelessWidget {
  final DateTime? selectedDate;
  final Function(DateTime) onDateChanged;

  const DateField({
    super.key,
    required this.selectedDate,
    required this.onDateChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
        );
        if (picked != null) onDateChanged(picked);
      },
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: 'Date',
          border: OutlineInputBorder(),
        ),
        child: Text(
          selectedDate != null
              ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
              : 'Select date',
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
