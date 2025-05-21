import 'package:flutter/material.dart';

class HearingFields extends StatelessWidget {
  final String? hearingLeft;
  final String? hearingRight;
  final void Function(String?) onLeftChanged;
  final void Function(String?) onRightChanged;

  const HearingFields({
    super.key,
    required this.hearingLeft,
    required this.hearingRight,
    required this.onLeftChanged,
    required this.onRightChanged,
  });

  @override
  Widget build(BuildContext context) {
    final options = ['Normal', 'Impaired', 'Deaf'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Hearing", style: TextStyle(fontWeight: FontWeight.bold)),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                value: hearingLeft,
                onChanged: onLeftChanged,
                decoration: const InputDecoration(labelText: 'Left Ear'),
                items: options
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Select value' : null,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: DropdownButtonFormField<String>(
                value: hearingRight,
                onChanged: onRightChanged,
                decoration: const InputDecoration(labelText: 'Right Ear'),
                items: options
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Select value' : null,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
