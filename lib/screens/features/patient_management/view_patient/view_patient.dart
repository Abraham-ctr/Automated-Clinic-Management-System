import 'package:automated_clinic_management_system/core/services/patient_service.dart';
import 'package:flutter/material.dart';

class ViewPatientsScreen extends StatefulWidget {
  const ViewPatientsScreen({super.key});

  @override
  State<ViewPatientsScreen> createState() => _ViewPatientsScreenState();
}

class _ViewPatientsScreenState extends State<ViewPatientsScreen> {
  final PatientService _patientService = PatientService();

  late Future<List<Map<String, dynamic>>> _patientsFuture;

  List<Map<String, dynamic>> _allPatients = [];
  List<Map<String, dynamic>> _filteredPatients = [];

  final TextEditingController _searchController = TextEditingController();

  String? _selectedDepartment;
  String? _selectedCourse;
  String? _selectedGender;

  int _currentPage = 0;
  static const int _pageSize = 10;

  @override
  void initState() {
    super.initState();
    _loadPatients();
    _searchController.addListener(_applyFilters);
  }

  @override
  void dispose() {
    _searchController.removeListener(_applyFilters);
    _searchController.dispose();
    super.dispose();
  }

  void _loadPatients() {
    setState(() {
      // _patientsFuture = _patientService.fetchAllPatients();
    });
    _patientsFuture.then((patients) {
      setState(() {
        _allPatients = patients;
        _applyFilters();
      });
    });
  }

  void _applyFilters() {
    final searchText = _searchController.text.trim().toLowerCase();
    List<Map<String, dynamic>> filtered = _allPatients.where((patient) {
      final form1 = patient['form1'] ?? {};
      final surname = (form1['surname'] ?? '').toString().toLowerCase();
      final firstName = (form1['firstName'] ?? '').toString().toLowerCase();
      final matricNumber =
          (form1['matricNumber'] ?? '').toString().toLowerCase();

      final matchesSearch = searchText.isEmpty ||
          surname.contains(searchText) ||
          firstName.contains(searchText) ||
          matricNumber.contains(searchText);

      final matchesDepartment = _selectedDepartment == null ||
          _selectedDepartment!.isEmpty ||
          (form1['department'] ?? '') == _selectedDepartment;

      final matchesCourse = _selectedCourse == null ||
          _selectedCourse!.isEmpty ||
          (form1['course'] ?? '') == _selectedCourse;

      final matchesGender = _selectedGender == null ||
          _selectedGender!.isEmpty ||
          (form1['sex'] ?? '') == _selectedGender;

      return matchesSearch &&
          matchesDepartment &&
          matchesCourse &&
          matchesGender;
    }).toList();

    setState(() {
      _filteredPatients = filtered;
      _currentPage = 0; // Reset page when filters change
    });
  }

  void _clearFilters() {
    _searchController.clear();
    setState(() {
      _selectedDepartment = null;
      _selectedCourse = null;
      _selectedGender = null;
    });
    _applyFilters();
  }

  List<Map<String, dynamic>> get _pagedPatients {
    final start = _currentPage * _pageSize;
    final end = start + _pageSize;
    if (start >= _filteredPatients.length) return [];
    return _filteredPatients.sublist(
        start, end > _filteredPatients.length ? _filteredPatients.length : end);
  }

  void _prevPage() {
    if (_currentPage > 0) {
      setState(() => _currentPage--);
    }
  }

  void _nextPage() {
    if ((_currentPage + 1) * _pageSize < _filteredPatients.length) {
      setState(() => _currentPage++);
    }
  }

  List<String> _extractFieldSet(String field) {
    final set = _allPatients
        .map((p) => (p['form1'] ?? {})[field]?.toString() ?? '')
        .where((v) => v.isNotEmpty)
        .toSet();
    final list = set.toList();
    list.sort();
    return list;
  }

  List<String> get _departments => _extractFieldSet('department');
  List<String> get _courses => _extractFieldSet('course');
  List<String> get _genders => _extractFieldSet('sex');

  void _showPatientDetailsDialog(Map<String, dynamic> patient) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return _PatientDetailsDialog(
          patient: patient,
          onSave: (updatedPatient) {
            setState(() {
              final indexAll =
                  _allPatients.indexWhere((p) => p['id'] == patient['id']);
              if (indexAll != -1) _allPatients[indexAll] = updatedPatient;

              final indexFiltered =
                  _filteredPatients.indexWhere((p) => p['id'] == patient['id']);
              if (indexFiltered != -1)
                _filteredPatients[indexFiltered] = updatedPatient;
            });
          },
          onDelete: () {
            setState(() {
              _allPatients.removeWhere((p) => p['id'] == patient['id']);
              _filteredPatients.removeWhere((p) => p['id'] == patient['id']);
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Patients')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _patientsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No patients found'));
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Search + Refresh
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          labelText: 'Search by name or matric number',
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      tooltip: 'Refresh',
                      icon: const Icon(Icons.refresh),
                      onPressed: () {
                        _clearFilters();
                        _loadPatients();
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Filters Row
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedDepartment ?? '',
                        decoration: const InputDecoration(
                          labelText: 'Filter by Department',
                          border: OutlineInputBorder(),
                        ),
                        items: [
                          const DropdownMenuItem(
                              value: '', child: Text('All Departments')),
                          ..._departments.map((dept) =>
                              DropdownMenuItem(value: dept, child: Text(dept))),
                        ],
                        onChanged: (value) {
                          setState(() => _selectedDepartment =
                              (value == '') ? null : value);
                          _applyFilters();
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedCourse ?? '',
                        decoration: const InputDecoration(
                          labelText: 'Filter by Course',
                          border: OutlineInputBorder(),
                        ),
                        items: [
                          const DropdownMenuItem(
                              value: '', child: Text('All Courses')),
                          ..._courses.map((course) => DropdownMenuItem(
                              value: course, child: Text(course))),
                        ],
                        onChanged: (value) {
                          setState(() =>
                              _selectedCourse = (value == '') ? null : value);
                          _applyFilters();
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedGender ?? '',
                        decoration: const InputDecoration(
                          labelText: 'Filter by Gender',
                          border: OutlineInputBorder(),
                        ),
                        items: [
                          const DropdownMenuItem(
                              value: '', child: Text('All Genders')),
                          ..._genders.map((gender) => DropdownMenuItem(
                              value: gender, child: Text(gender))),
                        ],
                        onChanged: (value) {
                          setState(() =>
                              _selectedGender = (value == '') ? null : value);
                          _applyFilters();
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    TextButton(
                      onPressed: _clearFilters,
                      child: const Text('Clear Filters'),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Patient List or Empty
                Expanded(
                  child: _filteredPatients.isEmpty
                      ? const Center(
                          child: Text('No patients match your filters'))
                      : ListView.builder(
                          itemCount: _pagedPatients.length,
                          itemBuilder: (context, index) {
                            final patient = _pagedPatients[index];
                            final form1 = patient['form1'] ?? {};

                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  _showPatientDetailsDialog(patient);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${form1['surname'] ?? ''} ${form1['firstName'] ?? ''}',
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                          'Matric Number: ${form1['matricNumber'] ?? 'N/A'}'),
                                      Text(
                                          'Department: ${form1['department'] ?? 'N/A'}'),
                                      Text(
                                          'Course: ${form1['course'] ?? 'N/A'}'),
                                      Text('Gender: ${form1['sex'] ?? 'N/A'}'),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),

                // Pagination controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: _currentPage == 0 ? null : _prevPage,
                      child: const Text('Previous'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Page ${_currentPage + 1} of ${(_filteredPatients.length / _pageSize).ceil()}',
                      ),
                    ),
                    TextButton(
                      onPressed: (_currentPage + 1) * _pageSize >=
                              _filteredPatients.length
                          ? null
                          : _nextPage,
                      child: const Text('Next'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _PatientDetailsDialog extends StatefulWidget {
  final Map<String, dynamic> patient;
  final Function(Map<String, dynamic> updatedPatient) onSave;
  final VoidCallback onDelete;

  const _PatientDetailsDialog({
    required this.patient,
    required this.onSave,
    required this.onDelete,
  });

  @override
  State<_PatientDetailsDialog> createState() => _PatientDetailsDialogState();
}

class _PatientDetailsDialogState extends State<_PatientDetailsDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _surnameController;
  late TextEditingController _firstNameController;
  late TextEditingController _matricController;
  late TextEditingController _departmentController;
  late TextEditingController _courseController;
  late TextEditingController _sexController;

  bool _isSaving = false;
  final PatientService _patientService = PatientService();

  @override
  void initState() {
    super.initState();
    final form1 = widget.patient['form1'] ?? {};

    _surnameController =
        TextEditingController(text: form1['surname']?.toString() ?? '');
    _firstNameController =
        TextEditingController(text: form1['firstName']?.toString() ?? '');
    _matricController =
        TextEditingController(text: form1['matricNumber']?.toString() ?? '');
    _departmentController =
        TextEditingController(text: form1['department']?.toString() ?? '');
    _courseController =
        TextEditingController(text: form1['course']?.toString() ?? '');
    _sexController =
        TextEditingController(text: form1['sex']?.toString() ?? '');
  }

  @override
  void dispose() {
    _surnameController.dispose();
    _firstNameController.dispose();
    _matricController.dispose();
    _departmentController.dispose();
    _courseController.dispose();
    _sexController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    try {
      final updatedForm1 = {
        'surname': _surnameController.text.trim(),
        'firstName': _firstNameController.text.trim(),
        'matricNumber': _matricController.text.trim(),
        'department': _departmentController.text.trim(),
        'course': _courseController.text.trim(),
        'sex': _sexController.text.trim(),
      };

      final updatedPatient = {
        ...widget.patient,
        'form1': updatedForm1,
      };

      // await _patientService.updatePatient(widget.patient['id'], updatedPatient);
      widget.onSave(updatedPatient);
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving changes: $e')),
      );
    } finally {
      setState(() => _isSaving = false);
    }
  }

  Future<void> _deletePatient() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Patient'),
        content: const Text('Are you sure you want to delete this patient?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      await _patientService.deletePatient(widget.patient['id']);
      widget.onDelete();
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting patient: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Patient Details'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: _surnameController,
                decoration: const InputDecoration(labelText: 'Surname'),
                validator: (value) =>
                    value!.isEmpty ? 'Surname is required' : null,
              ),
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: (value) =>
                    value!.isEmpty ? 'First name is required' : null,
              ),
              TextFormField(
                controller: _matricController,
                decoration: const InputDecoration(labelText: 'Matric Number'),
              ),
              TextFormField(
                controller: _departmentController,
                decoration: const InputDecoration(labelText: 'Department'),
              ),
              TextFormField(
                controller: _courseController,
                decoration: const InputDecoration(labelText: 'Course'),
              ),
              TextFormField(
                controller: _sexController,
                decoration: const InputDecoration(labelText: 'Gender'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSaving ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: _isSaving ? null : _deletePatient,
          child: const Text('Delete'),
        ),
        ElevatedButton(
          onPressed: _isSaving ? null : _saveChanges,
          child: _isSaving
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Save'),
        ),
      ],
    );
  }
}
