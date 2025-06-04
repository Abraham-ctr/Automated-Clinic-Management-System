import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:automated_clinic_management_system/core/providers/drug_provider.dart';
import 'package:automated_clinic_management_system/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart' as fl_chart;
import 'package:pie_chart/pie_chart.dart' as pie_chart;
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class DrugReportsPage extends StatefulWidget {
  const DrugReportsPage({super.key});

  @override
  State<DrugReportsPage> createState() => _DrugReportsPageState();
}

class _DrugReportsPageState extends State<DrugReportsPage> {
  DateTimeRange? selectedRange;

  // Keys for capturing charts as images
  final GlobalKey _barChartKey = GlobalKey();
  final GlobalKey _pieChartKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DrugProvider>(context, listen: false).fetchAllDrugData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DrugProvider>(context);

    return Scaffold(
      backgroundColor: AppConstants.lightGreyColor,
      appBar: AppBar(
        backgroundColor: AppConstants.priColor,
        title: const Text('Drug Reports & Analytics'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            tooltip: 'Export Report as PDF',
            onPressed: () => _generatePDFReport(provider),
          ),
        ],
      ),
      body: provider.isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppConstants.priColor))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  _buildStatCard("Total Drugs", provider.totalDrugs.toString(),
                      AppConstants.priColor),
                  _buildStatCard("Total Quantity",
                      provider.totalQuantity.toString(), AppConstants.secColor),
                  _buildStatCard(
                      "Expired Drugs",
                      provider.expiredDrugs.length.toString(),
                      Colors.redAccent),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstants.secColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () async {
                      final picked = await showDateRangePicker(
                        context: context,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        initialDateRange: selectedRange,
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.light(
                                primary: AppConstants.priColor,
                                onPrimary: Colors.white,
                                onSurface: AppConstants.darkGreyColor,
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (picked != null) {
                        setState(() {
                          selectedRange = picked;
                        });
                        await provider.fetchExpiringDrugsWithinRange(
                            picked.start, picked.end);
                      }
                    },
                    icon: const Icon(Icons.filter_alt),
                    label: const Text("Filter Expiring Drugs by Date"),
                  ),
                  if (selectedRange != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        "Showing drugs expiring between: "
                        "${selectedRange!.start.toLocal().toString().split(' ')[0]} and "
                        "${selectedRange!.end.toLocal().toString().split(' ')[0]}",
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          color: AppConstants.darkGreyColor,
                        ),
                      ),
                    ),
                  const SizedBox(height: 24),
                  const Text(
                    "Drug Distribution Overview",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: Wrap(
                      spacing: 32,
                      runSpacing: 20,
                      alignment: WrapAlignment.center,
                      children: [
                        // Wrap charts in RepaintBoundary with keys for capturing
                        RepaintBoundary(
                          key: _barChartKey,
                          child: SizedBox(
                            width: 400,
                            height: 350,
                            child: _buildCategoryBarChart(provider),
                          ),
                        ),
                        RepaintBoundary(
                          key: _pieChartKey,
                          child: SizedBox(
                            width: 350,
                            child: _buildCategoryPieChart(provider),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: color.withOpacity(0.15),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Text(value,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        title: Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.w600, color: AppConstants.darkGreyColor),
        ),
        trailing: Text(
          value,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: color),
        ),
      ),
    );
  }

  Widget _buildCategoryBarChart(DrugProvider provider) {
    final data = provider.categoryQuantityMap.entries.toList();

    if (data.isEmpty) {
      return const Center(
        child: Text("No data to display.",
            style: TextStyle(color: AppConstants.darkGreyColor)),
      );
    }

    final maxQuantity =
        data.map((e) => e.value).reduce((a, b) => a > b ? a : b).toDouble();
    final roundedMaxY = (maxQuantity + 10 - (maxQuantity % 10)).ceilToDouble();

    return fl_chart.BarChart(
      fl_chart.BarChartData(
        alignment: fl_chart.BarChartAlignment.spaceBetween,
        maxY: roundedMaxY,
        barTouchData: const fl_chart.BarTouchData(enabled: true),
        titlesData: fl_chart.FlTitlesData(
          bottomTitles: fl_chart.AxisTitles(
            sideTitles: fl_chart.SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index >= 0 && index < data.length) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SizedBox(
                      width: 50,
                      child: Text(
                        data[index].key,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 10),
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
              reservedSize: 60,
              interval: 1,
            ),
          ),
          leftTitles: fl_chart.AxisTitles(
            sideTitles: fl_chart.SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 5,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: const TextStyle(fontSize: 10),
                );
              },
            ),
          ),
          rightTitles: const fl_chart.AxisTitles(
              sideTitles: fl_chart.SideTitles(showTitles: false)),
          topTitles: const fl_chart.AxisTitles(
              sideTitles: fl_chart.SideTitles(showTitles: false)),
        ),
        gridData: fl_chart.FlGridData(
          show: true,
          checkToShowHorizontalLine: (value) {
            return true;
          },
          getDrawingHorizontalLine: (value) => fl_chart.FlLine(
            color: Colors.grey.withOpacity(0.2),
            strokeWidth: 1,
          ),
        ),
        borderData: fl_chart.FlBorderData(
          show: true,
          border: const Border(
            left: BorderSide(color: Colors.black12),
            bottom: BorderSide(color: Colors.black12),
          ),
        ),
        barGroups: data.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          return fl_chart.BarChartGroupData(
            x: index,
            barsSpace: 500,
            barRods: [
              fl_chart.BarChartRodData(
                toY: item.value.toDouble(),
                color: AppConstants.secColor,
                width: 15,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCategoryPieChart(DrugProvider provider) {
    final data = provider.categoryQuantityMap;
    if (data.isEmpty) {
      return const Text("No data to display.",
          style: TextStyle(color: AppConstants.darkGreyColor));
    }

    return pie_chart.PieChart(
      dataMap: data.map((k, v) => MapEntry(k, v.toDouble())),
      chartType: pie_chart.ChartType.ring,
      chartRadius: 220,
      ringStrokeWidth: 24,
      colorList: const [
        AppConstants.priColor,
        AppConstants.secColor,
        Colors.orangeAccent,
        Colors.redAccent,
        Colors.greenAccent,
        Colors.blueAccent,
        Colors.purpleAccent,
      ],
      legendOptions: const pie_chart.LegendOptions(
        showLegendsInRow: false,
        legendPosition: pie_chart.LegendPosition.right,
        legendTextStyle: TextStyle(fontSize: 10),
      ),
      chartValuesOptions: const pie_chart.ChartValuesOptions(
        showChartValuesInPercentage: true,
        showChartValuesOutside: true,
        decimalPlaces: 1,
      ),
    );
  }

  // Capture the widget image from its RepaintBoundary key
  Future<Uint8List?> _capturePng(GlobalKey key) async {
    try {
      RenderRepaintBoundary boundary =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      debugPrint('Error capturing image: $e');
      return null;
    }
  }

  Future<void> _generatePDFReport(DrugProvider provider) async {
    final pdf = pw.Document();

    // Capture chart images
    final barChartBytes = await _capturePng(_barChartKey);
    final pieChartBytes = await _capturePng(_pieChartKey);

    // Convert captured images to MemoryImage for PDF
    final barChartImage =
        barChartBytes != null ? pw.MemoryImage(barChartBytes) : null;
    final pieChartImage =
        pieChartBytes != null ? pw.MemoryImage(pieChartBytes) : null;

    final data = provider.categoryQuantityMap;

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("DomiCare Drug Report",
                style:
                    pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 20),
            pw.Text("Total Drugs: ${provider.totalDrugs}"),
            pw.Text("Total Quantity: ${provider.totalQuantity}"),
            pw.Text("Expired Drugs: ${provider.expiredDrugs.length}"),
            pw.SizedBox(height: 20),
            pw.Text("Category Breakdown:",
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            ...data.entries
                .map((entry) => pw.Text("${entry.key}: ${entry.value}")),
            pw.SizedBox(height: 20),
            if (barChartImage != null) ...[
              pw.Text("Category Bar Chart:",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              pw.Image(barChartImage, width: 400, height: 250),
              pw.SizedBox(height: 20),
            ],
            if (pieChartImage != null) ...[
              pw.Text("Category Pie Chart:",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              pw.Image(pieChartImage, width: 300, height: 300),
            ],
          ],
        ),
      ),
    );

    await Printing.layoutPdf(onLayout: (format) async => pdf.save());
  }
}
