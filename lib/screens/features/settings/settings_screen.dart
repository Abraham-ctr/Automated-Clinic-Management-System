import 'package:automated_clinic_management_system/core/providers/theme_provider.dart';
import 'package:automated_clinic_management_system/widgets/form_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  // final AuthService authService = AuthService();

  void _exportPatientData(BuildContext context, String filter) async {
    try {
      Query patientsQuery = FirebaseFirestore.instance.collection('patients');

      // Apply filtering
      if (filter == "By Registration Date") {
        patientsQuery =
            patientsQuery.orderBy("registrationDate", descending: true);
      } else if (filter == "By Age Range") {
        patientsQuery = patientsQuery.orderBy("age");
      } else if (filter == "By Gender") {
        patientsQuery = patientsQuery.orderBy("gender");
      }

      QuerySnapshot snapshot = await patientsQuery.get();

      List<List<dynamic>> rows = [];
      rows.add(["ID", "Name", "Age", "Gender", "Registration Date"]);

      for (var doc in snapshot.docs) {
        rows.add([
          doc.id,
          doc["fullName"],
          doc["age"],
          doc["gender"],
          doc["registrationDate"]
        ]);
      }

      // Ask user whether to export as CSV or Excel
      _showExportFormatDialog(context, rows, "patients");
    } catch (e) {
      debugPrint("Export failed: $e");
    }
  }

  void _exportDrugData(BuildContext context, String filter) async {
    try {
      Query drugsQuery = FirebaseFirestore.instance.collection('drugs');

      // Apply filtering
      if (filter == "By Stock Availability") {
        drugsQuery = drugsQuery.orderBy("stockQuantity", descending: true);
      } else if (filter == "By Expiry Date") {
        drugsQuery = drugsQuery.orderBy("expiryDate");
      } else if (filter == "By Category") {
        drugsQuery = drugsQuery.orderBy("category");
      }

      QuerySnapshot snapshot = await drugsQuery.get();

      List<List<dynamic>> rows = [];
      rows.add(["ID", "Drug Name", "Category", "Stock", "Expiry Date"]);

      for (var doc in snapshot.docs) {
        rows.add([
          doc.id,
          doc["name"],
          doc["category"],
          doc["stockQuantity"],
          doc["expiryDate"],
        ]);
      }

      // ✅ Pass the `context` here
      _showExportFormatDialog(context, rows, "drugs");
    } catch (e) {
      debugPrint("Export failed: $e");
    }
  }

  void _showExportFormatDialog(
      BuildContext context, List<List<dynamic>> data, String fileName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Choose Export Format"),
          content: const Text("Do you want to export as CSV or Excel?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _saveCsvFile(data, fileName);
              },
              child: const Text("CSV"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _saveExcelFile(data, fileName);
              },
              child: const Text("Excel"),
            ),
          ],
        );
      },
    );
  }

  void _saveCsvFile(List<List<dynamic>> data, String fileName) async {
    String csvData = const ListToCsvConverter().convert(data);

    final directory = await getApplicationDocumentsDirectory();
    final path = "${directory.path}/$fileName.csv";
    final file = File(path);

    await file.writeAsString(csvData);

    debugPrint("CSV file saved at: $path");
  }

  void _saveExcelFile(List<List<dynamic>> data, String fileName) async {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel[fileName];

    for (var row in data) {
      sheetObject
          .appendRow(row.map((e) => TextCellValue(e.toString())).toList());
    }

    final directory = await getApplicationDocumentsDirectory();
    final path = "${directory.path}/$fileName.xlsx";
    final file = File(path);

    await file.writeAsBytes(excel.encode()!);

    debugPrint("Excel file saved at: $path");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Center(
            child: ListView(children: [
          FormHeader(text: "Settings", onPressed: ()=> Navigator.pop),
          const SizedBox(height: 10),

          // Profile Settings
          _buildSettingsSection(
            title: "Profile Settings",
            children: [
              _buildSettingsItem(Icons.person, "Update Personal Info", () {
                // Navigate to update profile screen
              }),
              _buildSettingsItem(Icons.lock, "Change Password", () {
                // Navigate to change password screen
              }),
              _buildSettingsItem(Icons.email, "Forgot Password", () {
                // Forgot password functionality
              }),
            ],
          ),

          // Clinic Settings (Placeholder)
          _buildSettingsSection(
            title: "Clinic Settings",
            children: [
              _buildSettingsItem(Icons.local_hospital, "Clinic Preferences",
                  () {
                // Future: Add clinic-related settings
                Navigator.pushNamed(context, "/notifications");
              }),
            ],
          ),

          // Data Management
          _buildSettingsSection(
            title: "Data Management",
            children: [
              _buildSettingsItem(Icons.file_download, "Export Patient Records",
                  () {
                // Export patient records functionality
                _showPatientExportDialog(context);
              }),
              _buildSettingsItem(Icons.file_download, "Export Drug Inventory",
                  () {
                // Export drug inventory functionality
                _showDrugExportDialog(context);
              }),
            ],
          ),

          // Theme Settings
          _buildSettingsSection(
            title: "Theme Settings",
            children: [
              Consumer<ThemeProvider>(
                builder: (context, themeProvider, child) {
                  return SwitchListTile(
                    title: Text(
                        themeProvider.isDarkMode ? "Dark Mode" : "Light Mode"),
                    value: themeProvider.isDarkMode,
                    onChanged: (value) {
                      themeProvider.toggleTheme();
                    },
                    secondary: Icon(
                      themeProvider.isDarkMode
                          ? Icons.nightlight_round
                          : Icons.wb_sunny,
                      color: themeProvider.isDarkMode
                          ? Colors.white
                          : Colors.orange,
                    ),
                  );
                },
              ),
            ],
          ),

          // Logout
          _buildSettingsSection(
            title: "Logout",
            children: [
              _buildSettingsItem(Icons.logout, "Sign Out", () {
                // Logout functionality
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Confirm Logout"),
                      content: const Text("Are you sure you want to log out?"),
                      actions: [
                        TextButton(
                          onPressed: () =>
                              Navigator.pop(context), // Close dialog
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Close dialog
                            // authService.logoutUser(context: context); // Proceed with logout
                          },
                          child: const Text("Logout",
                              style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    );
                  },
                );
              }, color: Colors.red),
            ],
          ),

          const SizedBox(height: 20),
        ])));
  }

  // Helper function to create settings sections
  Widget _buildSettingsSection(
      {required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ...children,
        const Divider(),
      ],
    );
  }

  // Helper function to create individual settings items
  Widget _buildSettingsItem(IconData icon, String title, VoidCallback onTap,
      {Color color = Colors.black87}) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title),
      onTap: onTap,
    );
  }

  void _showPatientExportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String selectedFilter = "All Patients"; // Default selection

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Export Patient Records"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButton<String>(
                    value: selectedFilter,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedFilter = newValue!;
                      });
                    },
                    items: [
                      "All Patients",
                      "By Registration Date",
                      "By Age Range",
                      "By Gender",
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _exportPatientData(context, selectedFilter);
                  },
                  child: const Text("Export"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showDrugExportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String selectedFilter = "All Drugs"; // Default selection

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Export Drug Inventory"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButton<String>(
                    value: selectedFilter,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedFilter = newValue!;
                      });
                    },
                    items: [
                      "All Drugs",
                      "By Stock Availability",
                      "By Expiry Date",
                      "By Category",
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _exportDrugData(context, selectedFilter);
                  },
                  child: const Text("Export"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
