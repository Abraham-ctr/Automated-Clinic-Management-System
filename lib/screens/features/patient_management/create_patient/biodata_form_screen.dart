import 'package:automated_clinic_management_system/core/utils/constants.dart';
import 'package:automated_clinic_management_system/core/utils/routes.dart';
import 'package:automated_clinic_management_system/core/utils/utilities.dart';
import 'package:automated_clinic_management_system/widgets/form_header.dart';
import 'package:flutter/material.dart';
import 'package:automated_clinic_management_system/core/services/patient_service.dart';
import 'package:automated_clinic_management_system/models/patient.dart';
import 'package:automated_clinic_management_system/widgets/auth/my_button.dart';

class BiodataFormScreen extends StatefulWidget {
  const BiodataFormScreen({super.key});

  @override
  _BiodataFormScreenState createState() => _BiodataFormScreenState();
}

class _BiodataFormScreenState extends State<BiodataFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final PatientService _patientService = PatientService();
  bool _isSaving = false;

  // Form controllers
  final TextEditingController _matricController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _otherNamesController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _parentPhoneController = TextEditingController();
  final TextEditingController _kinPhoneController = TextEditingController();
  final TextEditingController _parentNameController = TextEditingController();
  final TextEditingController _kinNameController = TextEditingController();
  final TextEditingController _birthPlaceController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  DateTime? _dob;
  String _sex = 'Male';
  String _maritalStatus = 'Single';
  String _nationality = 'Nigeria';

  // Department and Programme state
  String? _selectedDepartment;
  String? _selectedProgramme;

  // Data for departments and programmes
  final Map<String, List<String>> _departmentProgrammes = {
    'Allied Health Sciences': [
      'BSc Nursing',
      'BSc Public Health',
      'BSc Medical Laboratory Science'
    ],
    'Biological Sciences': [
      'BSc Microbiology',
    ],
    'Chemical Sciences': [
      'BSc Biochemistry',
      'BSc Industrial Chemistry',
    ],
    'Computer Science': [
      'BSc Computer Science',
      'BSc Cybersecurity',
      'BSc Software Engineering'
    ],
    'Criminology & Security Studies': [
      'BSc Criminology & Security Studies',
    ],
    'Management Sciences': [
      'BSc Accounting',
      'BSc Business Administration',
      'BSc Economics',
    ],
    'Mass Communication': [
      'BSc Mass Communication',
    ],
  };

  // West African countries for nationality dropdown
  final List<String> _westAfricanCountries = [
    'Benin',
    'Burkina Faso',
    'Cabo Verde',
    'Côte d\'Ivoire',
    'Gambia',
    'Ghana',
    'Guinea',
    'Guinea-Bissau',
    'Liberia',
    'Mali',
    'Mauritania',
    'Niger',
    'Nigeria',
    'Senegal',
    'Sierra Leone',
    'Togo'
  ];

  @override
  void initState() {
    super.initState();
    _dobController.addListener(_updateDobDisplay);
  }

  @override
  void dispose() {
    _matricController.dispose();
    _surnameController.dispose();
    _firstNameController.dispose();
    _otherNamesController.dispose();
    _phoneController.dispose();
    _parentPhoneController.dispose();
    _kinPhoneController.dispose();
    _parentNameController.dispose();
    _kinNameController.dispose();
    _birthPlaceController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  void _updateDobDisplay() {
    if (_dob != null) {
      _dobController.text = '${_dob!.day}/${_dob!.month}/${_dob!.year}';
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppConstants.priColor,
              onPrimary: Colors.white,
              onSurface: AppConstants.darkGreyColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppConstants.priColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _dob = picked);
      _updateDobDisplay();
    }
  }

  // Submit function
  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      final biodata = PatientBiodata(
        matricNumber: _matricController.text.trim().toUpperCase(),
        surname: capitalizeAndTrim(_surnameController.text),
        firstName: capitalizeAndTrim(_firstNameController.text),
        otherNames: capitalizeAndTrim(_otherNamesController.text),
        dateOfBirth: _dob!,
        sex: _sex,
        maritalStatus: _maritalStatus,
        nationality: _nationality,
        placeOfBirth: capitalizeAndTrim(_birthPlaceController.text),
        phoneNumber: addPrefixToPhoneNumber(_phoneController.text.trim()),
        department: capitalizeAndTrim(_selectedDepartment ?? ''),
        programme: capitalizeAndTrim(_selectedProgramme ?? ''),
        nameOfParentOrGuardian: capitalizeAndTrim(_parentNameController.text),
        phoneNumberOfParentOrGuardian:
            addPrefixToPhoneNumber(_parentPhoneController.text.trim()),
        nameOfNextOfKin: capitalizeAndTrim(_kinNameController.text),
        phoneNumberOfNextOfKin:
            addPrefixToPhoneNumber(_kinPhoneController.text.trim()),
      );

      await _patientService.saveBiodata(biodata);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Patient saved successfully!')),
      );
      // Navigate to the MedicalTestScreen
      Navigator.pushNamed(
        context,
        AppRoutes.medicalTest,
        arguments: biodata,
      );

      // Optionally, clear form or navigate away
      _formKey.currentState!.reset();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving patient: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> programmes = _selectedDepartment != null
        ? _departmentProgrammes[_selectedDepartment] ?? <String>[]
        : <String>[];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 30.0, left: 30, right: 30, bottom: 10),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Material(
              elevation: 10,
              child: Scrollbar(
                controller: _scrollController,
                thickness: 5,
                interactive: true,
                trackVisibility: true,
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          // borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormHeader(
                            text: "Biodata",
                            onPressed: () {
                              Navigator.pushNamed(context, AppRoutes.dashboard);
                            },
                          ),
                          // Personal Information Section
                          _buildSectionHeader('Personal Information'),
                          _buildTextFormField(
                            controller: _matricController,
                            label: 'Matric Number',
                            icon: Icons.badge,
                            validator: (v) => v!.isEmpty ? 'Required' : null,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: _buildTextFormField(
                                  controller: _surnameController,
                                  label: 'Surname',
                                  icon: Icons.person_outline,
                                  validator: (v) =>
                                      v!.isEmpty ? 'Required' : null,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: _buildTextFormField(
                                  controller: _firstNameController,
                                  label: 'First Name',
                                  icon: Icons.person_outline,
                                  validator: (v) =>
                                      v!.isEmpty ? 'Required' : null,
                                ),
                              ),
                            ],
                          ),
                          _buildTextFormField(
                            controller: _otherNamesController,
                            label: 'Other Names',
                            icon: Icons.person_outline,
                          ),
                          _buildDatePickerField(),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: _buildDropdown(
                                  value: _sex,
                                  items: ['Male', 'Female'],
                                  label: 'Gender',
                                  icon: Icons.transgender,
                                  onChanged: (value) =>
                                      setState(() => _sex = value!),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: _buildDropdown(
                                  value: _maritalStatus,
                                  items: [
                                    'Single',
                                    'Married',
                                    'Divorced',
                                    'Widowed'
                                  ],
                                  label: 'Marital Status',
                                  icon: Icons.family_restroom,
                                  onChanged: (value) =>
                                      setState(() => _maritalStatus = value!),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          _buildDropdown(
                            value: _nationality,
                            items: _westAfricanCountries,
                            label: 'Nationality',
                            icon: Icons.flag_outlined,
                            onChanged: (value) =>
                                setState(() => _nationality = value!),
                          ),
                          _buildTextFormField(
                            controller: _birthPlaceController,
                            label: 'Place of Birth',
                            icon: Icons.place_outlined,
                          ),

                          // Academic Information Section
                          _buildSectionHeader('Academic Information'),
                          _buildDropdown(
                            value: _selectedDepartment,
                            items: _departmentProgrammes.keys.toList(),
                            label: 'Department',
                            icon: Icons.school_outlined,
                            onChanged: (value) {
                              setState(() {
                                _selectedDepartment = value;
                                _selectedProgramme = null;
                              });
                            },
                            validator: (value) => value == null
                                ? 'Please select a department'
                                : null,
                          ),
                          const SizedBox(height: 10),
                          _buildDropdown(
                            value: _selectedProgramme,
                            items: programmes,
                            label: 'Programme',
                            icon: Icons.menu_book_outlined,
                            onChanged: _selectedDepartment == null
                                ? null
                                : (value) =>
                                    setState(() => _selectedProgramme = value),
                            disabledHint: 'Select department first',
                            validator: (value) => value == null
                                ? 'Please select a programme'
                                : null,
                          ),

                          // Contact Information Section
                          _buildSectionHeader('Contact Information'),
                          _buildTextFormField(
                            controller: _phoneController,
                            label: 'Phone Number',
                            keyboardType: TextInputType.phone,
                            icon: Icons.phone_android_outlined,
                            validator: (v) =>
                                v!.length < 11 ? 'Invalid phone' : null,
                          ),
                          const SizedBox(height: 15),
                          _buildSubSectionHeader('Parent/Guardian Information'),
                          _buildTextFormField(
                            controller: _parentNameController,
                            label: 'Parent/Guardian Name',
                            icon: Icons.supervisor_account_outlined,
                            validator: (v) => v!.isEmpty ? 'Required' : null,
                          ),
                          _buildTextFormField(
                            controller: _parentPhoneController,
                            label: 'Parent/Guardian Phone',
                            keyboardType: TextInputType.phone,
                            icon: Icons.phone_outlined,
                            validator: (v) =>
                                v!.length < 11 ? 'Invalid phone' : null,
                          ),
                          const SizedBox(height: 15),
                          _buildSubSectionHeader('Next of Kin Information'),
                          _buildTextFormField(
                            controller: _kinNameController,
                            label: 'Next of Kin Name',
                            icon: Icons.contact_emergency_outlined,
                            validator: (v) => v!.isEmpty ? 'Required' : null,
                          ),
                          _buildTextFormField(
                            controller: _kinPhoneController,
                            label: 'Next of Kin Phone',
                            keyboardType: TextInputType.phone,
                            icon: Icons.phone_outlined,
                            validator: (v) =>
                                v!.length < 11 ? 'Invalid phone' : null,
                          ),
                          const SizedBox(height: 30),
                          Center(
                            child: SizedBox(
                              width: double.infinity,
                              child: MyButton(
                                text: 'Save Biodata & Continue',
                                onPressed: _submitForm,
                                isPrimary: true,
                                isLoading: _isSaving,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: AppConstants.priColor,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildSubSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppConstants.priColor,
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    IconData? icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: AppConstants.darkGreyColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppConstants.middleGreyColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppConstants.middleGreyColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppConstants.priColor,
              width: 2,
            ),
          ),
          filled: true,
          fillColor: AppConstants.whiteColor,
          prefixIcon: icon != null ? Icon(icon, color: Colors.black) : null,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        ),
        keyboardType: keyboardType,
        validator: validator,
      ),
    );
  }

  Widget _buildDatePickerField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        readOnly: true,
        controller: _dobController,
        decoration: InputDecoration(
          labelText: 'Date of Birth',
          labelStyle: const TextStyle(color: AppConstants.darkGreyColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppConstants.middleGreyColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppConstants.middleGreyColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppConstants.priColor,
              width: 2,
            ),
          ),
          filled: true,
          fillColor: AppConstants.whiteColor,
          prefixIcon: const Icon(Icons.calendar_today, color: Colors.black),
          suffixIcon: IconButton(
            icon: const Icon(Icons.edit_outlined, color: Colors.black),
            onPressed: () => _selectDate(context),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        ),
        onTap: () => _selectDate(context),
        validator: (value) =>
            _dob == null ? 'Please select date of birth' : null,
      ),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required List<String> items,
    required String label,
    required IconData icon,
    String? disabledHint,
    String? Function(String?)? validator,
    void Function(String?)? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: DropdownButtonFormField<String>(
        value: value,
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item, style: const TextStyle(color: Colors.black)),
          );
        }).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: AppConstants.darkGreyColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppConstants.middleGreyColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppConstants.middleGreyColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppConstants.priColor,
              width: 2,
            ),
          ),
          filled: true,
          fillColor: AppConstants.whiteColor,
          prefixIcon: Icon(icon, color: Colors.black),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        ),
        style: const TextStyle(color: AppConstants.darkGreyColor, fontSize: 16),
        icon: const Icon(Icons.arrow_drop_down,
            color: AppConstants.darkGreyColor),
        dropdownColor: AppConstants.whiteColor,
        validator: validator,
        disabledHint: disabledHint != null
            ? Text(disabledHint,
                style: const TextStyle(color: AppConstants.middleGreyColor))
            : null,
      ),
    );
  }
}
