import 'package:automated_clinic_management_system/core/providers/drug_provider.dart';
import 'package:automated_clinic_management_system/core/utils/routes.dart';
import 'package:automated_clinic_management_system/widgets/form_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrugAlertsPage extends StatefulWidget {
  const DrugAlertsPage({super.key});

  @override
  State<DrugAlertsPage> createState() => _DrugAlertsPageState();
}

class _DrugAlertsPageState extends State<DrugAlertsPage> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<DrugProvider>(context, listen: false);
    provider.fetchLowStockDrugs();
    provider.fetchExpiringSoonDrugs();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DrugProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormHeader(
                    text: 'Drug Alerts',
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.dashboard),
                  ),
                  _buildLowStockSection(provider),
                  const SizedBox(height: 20),
                  _buildExpiringSoonSection(provider),
                ],
              ),
            ),
    );
  }

  Widget _buildLowStockSection(DrugProvider provider) {
    if (provider.lowStockDrugs.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(12.0),
        child: Text("No low stock drugs 🎉"),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          child: Text(
            "Low Stock Drugs",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        ...provider.lowStockDrugs.map((drug) {
          return Card(
            color: drug.quantity == 0
                ? Colors.red.shade100
                : Colors.orange.shade100,
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: Icon(
                Icons.warning,
                color: drug.quantity == 0 ? Colors.red : Colors.orange,
              ),
              title: Text(drug.name),
              subtitle: Text(
                  "Quantity: ${drug.quantity} | Category: ${drug.category}"),
              trailing: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.viewDrug);
                },
                child: const Text("Restock"),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildExpiringSoonSection(DrugProvider provider) {
    if (provider.expiringSoonDrugs.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(12.0),
        child: Text("No drugs expiring soon 🎉"),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          child: Text(
            "Expiring Soon (within 30 days)",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        ...provider.expiringSoonDrugs.map((drug) {
          return Card(
            color: Colors.yellow.shade100,
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: const Icon(Icons.schedule, color: Colors.orange),
              title: Text(drug.name),
              subtitle: Text(
                "Expires on: ${drug.expiryDate?.toLocal().toString().split(' ')[0]}",
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}
