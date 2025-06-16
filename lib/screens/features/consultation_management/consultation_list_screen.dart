import 'package:automated_clinic_management_system/core/services/consultation_service.dart';
import 'package:automated_clinic_management_system/models/consultation_model.dart';
import 'package:automated_clinic_management_system/core/utils/constants.dart';
import 'package:automated_clinic_management_system/core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConsultationListScreen extends StatelessWidget {
  final ConsultationService _consultationService = ConsultationService();

  ConsultationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consultation History'),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Consultation>>(
        stream: _consultationService.getConsultations(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
                child: Text('Error loading consultations: ${snapshot.error}'));
          }
          final consultations = snapshot.data ?? [];

          if (consultations.isEmpty) {
            return const Center(child: Text('No consultations available'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: consultations.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final consult = consultations[index];
              final formattedDate = DateFormat('MMM d, y h:mm a')
                  .format(consult.dateCreated.toDate());

              return Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text('Diagnosis: ${consult.diagnosis}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text('Complaints: ${consult.complaints}'),
                      Text('Treatment: ${consult.treatment}'),
                      if (consult.notes != null && consult.notes!.isNotEmpty)
                        Text('Notes: ${consult.notes}'),
                      const SizedBox(height: 6),
                      Text('Created by: ${consult.createdBy}',
                          style: const TextStyle(fontSize: 12)),
                      Text('Date: $formattedDate',
                          style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        Navigator.pushNamed(context, AppRoutes.editConsult,
                            arguments: consult);
                      } else if (value == 'delete') {
                        _confirmDelete(context, consult.id!);
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(value: 'edit', child: Text('Edit')),
                      const PopupMenuItem(
                          value: 'delete', child: Text('Delete')),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.pushNamed(context, AppRoutes.newConsultation),
        backgroundColor: AppConstants.priColor,
        tooltip: 'Add New Consultation',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _confirmDelete(BuildContext context, String consultationId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Consultation'),
        content:
            const Text('Are you sure you want to delete this consultation?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              try {
                await _consultationService.deleteConsultation(consultationId);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Consultation deleted successfully')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error deleting consultation: $e')),
                );
              }
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
