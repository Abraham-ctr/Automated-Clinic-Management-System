import 'package:flutter/material.dart';

class DepartmentDropdown extends StatelessWidget {
  final String? selectedDepartment;
  final void Function(String?) onChanged;
  final List<String> departments;

  const DepartmentDropdown({
    super.key,
    required this.selectedDepartment,
    required this.onChanged,
    required this.departments,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Department',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        value: selectedDepartment,
        items: departments
            .map((dept) => DropdownMenuItem(value: dept, child: Text(dept)))
            .toList(),
        onChanged: onChanged,
        validator: (val) =>
            val == null || val.isEmpty ? 'Select a department' : null,
      ),
    );
  }
}

class CourseDropdown extends StatelessWidget {
  final String? selectedCourse;
  final void Function(String?) onChanged;
  final List<String> courses;

  const CourseDropdown({
    super.key,
    required this.selectedCourse,
    required this.onChanged,
    required this.courses,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Course',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        value: selectedCourse,
        items: courses
            .map((course) =>
                DropdownMenuItem(value: course, child: Text(course)))
            .toList(),
        onChanged: onChanged,
        validator: (val) =>
            val == null || val.isEmpty ? 'Select a course' : null,
      ),
    );
  }
}
