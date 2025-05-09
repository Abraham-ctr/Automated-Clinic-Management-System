import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NationalityDropdown extends StatefulWidget {
  final String? value;
  final void Function(String?) onChanged;
  final String? Function(String?)? validator;

  const NationalityDropdown({
    super.key,
    required this.value,
    required this.onChanged,
    this.validator,
  });

  @override
  State<NationalityDropdown> createState() => _NationalityDropdownState();
}

class _NationalityDropdownState extends State<NationalityDropdown> {
  List<String> _nationalities = [];

  @override
  void initState() {
    super.initState();
    _fetchNationalities();
  }

  Future<void> _fetchNationalities() async {
    try {
      final response =
          await http.get(Uri.parse('https://restcountries.com/v3.1/all'));
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        final List<String> names = data
            .map((country) => country['name']['common'].toString())
            .toList()
          ..sort();

        setState(() {
          _nationalities = names;
        });
      } else {
        throw Exception('Failed to load countries');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading nationalities: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Nationality',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        value: widget.value,
        items: _nationalities
            .map((nationality) =>
                DropdownMenuItem(value: nationality, child: Text(nationality)))
            .toList(),
        onChanged: widget.onChanged,
        validator: widget.validator ??
            (val) => val == null || val.isEmpty
                ? 'Please select a nationality'
                : null,
      ),
    );
  }
}
