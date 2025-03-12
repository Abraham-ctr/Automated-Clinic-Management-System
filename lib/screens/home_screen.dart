import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/admin_provider.dart';
import '../widgets/app_bar.dart';
import '../widgets/flash_card.dart';
import '../widgets/side_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String currentTime = "";
  String flippedCardTitle = "";

  @override
  void initState() {
    super.initState();
    Provider.of<AdminProvider>(context, listen: false).fetchAdminDetails();
    updateTime();
  }

  void updateTime() {
    setState(() {
      currentTime = DateFormat('hh:mm a, EEEE, MMMM d, yyyy').format(DateTime.now());
    });
    Future.delayed(const Duration(seconds: 1), updateTime);
  }

  void flipCard(String title, bool isFlipped) {
    setState(() {
      flippedCardTitle = isFlipped ? title : "";
    });
  }

  @override
  Widget build(BuildContext context) {
    final adminProvider = Provider.of<AdminProvider>(context);

    List<Map<String, dynamic>> features = [
      {"title": "Patient Management", "desc": "Create & Manage patient records", "color": Colors.blue},
      {"title": "Consultations", "desc": "Record treatments & Physical consultations", "color": Colors.green},
      {"title": "Drug Inventory", "desc": "Manage medicine stock", "color": Colors.orange},
      {"title": "Notifications", "desc": "Check/Receive alerts", "color": Colors.purple},
      {"title": "Reports", "desc": "View system reports", "color": Colors.red},
    ];

    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const Sidebar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Text(
              "Welcome, ${adminProvider.firstName}",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              "Reg Number: ${adminProvider.regNumber}",
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            Center(
              child: Column(
                children: [
                  // First row (3 cards)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: features.sublist(0, 3).map((feature) {
                      return Padding(
                        padding: const EdgeInsets.all(12),
                        child: FlashCard(
                          title: feature["title"],
                          description: feature["desc"],
                          color: feature["color"],
                          isFlipped: flippedCardTitle == feature["title"],
                          onFlip: (isFlipped) => flipCard(feature["title"], isFlipped),
                          onOpen: () {},
                        ),
                      );
                    }).toList(),
                  ),

                  // Second row (2 cards)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: features.sublist(3, 5).map((feature) {
                      return Padding(
                        padding: const EdgeInsets.all(12),
                        child: FlashCard(
                          title: feature["title"],
                          description: feature["desc"],
                          color: feature["color"],
                          isFlipped: flippedCardTitle == feature["title"],
                          onFlip: (isFlipped) => flipCard(feature["title"], isFlipped),
                          onOpen: () {},
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Current Time: $currentTime",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
