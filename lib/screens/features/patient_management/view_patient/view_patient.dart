import 'package:automated_clinic_management_system/core/services/patient_service.dart';
import 'package:automated_clinic_management_system/core/utils/constants.dart';
import 'package:automated_clinic_management_system/core/utils/routes.dart';
import 'package:automated_clinic_management_system/models/patient.dart';
import 'package:automated_clinic_management_system/screens/features/patient_management/view_patient/patient_detail_screen.dart';
import 'package:automated_clinic_management_system/widgets/form_header.dart';
import 'package:flutter/material.dart';

class ViewPatientsScreen extends StatefulWidget {
  const ViewPatientsScreen({super.key});

  @override
  State<ViewPatientsScreen> createState() => _ViewPatientsScreenState();
}

class _ViewPatientsScreenState extends State<ViewPatientsScreen> {
  final PatientService _patientService = PatientService();

  // Full list from stream
  List<Patient> _allPatients = [];

  // Filtered list for display based on search
  List<Patient> _filteredPatients = [];

  // Search query controller
  final TextEditingController _searchController = TextEditingController();

  // To trigger manual refresh
  final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();

    setState(() {
      if (query.isEmpty) {
        _filteredPatients = List.from(_allPatients);
      } else {
        _filteredPatients = _allPatients.where((patient) {
          final fullName =
              '${patient.biodata.surname} ${patient.biodata.firstName}'
                  .toLowerCase();
          final matric = patient.biodata.matricNumber.toLowerCase();
          return fullName.contains(query) || matric.contains(query);
        }).toList();
      }
    });
  }

  Future<void> _refresh() async {
    // Just rebuild to trigger StreamBuilder to re-listen,
    // or you can implement specific refresh logic if needed.
    setState(() {});
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          FormHeader(
              text: 'Patients',
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.dashboard)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                labelText: 'Search by name or matric number',
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              key: _refreshKey,
              onRefresh: _refresh,
              child: StreamBuilder<List<Patient>>(
                stream: _patientService.streamAllPatients(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(
                        child:
                            Text('Error loading patients: ${snapshot.error}'));
                  }
                  _allPatients = snapshot.data ?? [];
                  // Filter based on current search query
                  final patientsToShow = _searchController.text.isEmpty
                      ? _allPatients
                      : _filteredPatients;

                  if (patientsToShow.isEmpty) {
                    return const Center(child: Text('No patients found.'));
                  }
                  return ListView.separated(
                    itemCount: patientsToShow.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final patient = patientsToShow[index];
                      final fullName =
                          '${patient.biodata.surname} ${patient.biodata.firstName}';

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Column(
                          children: [
                            ListTile(
                              leading:
                                  const CircleAvatar(child: Icon(Icons.person)),
                              title: Text(
                                fullName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppConstants.priColor),
                              ),
                              subtitle: Text(
                                  'Matric Number: ${patient.biodata.matricNumber}'),
                              trailing:
                                  const Icon(Icons.arrow_forward_ios, size: 16),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        PatientDetailScreen(patient: patient),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
