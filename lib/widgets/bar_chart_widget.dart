import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartWidget extends StatelessWidget {
  final Map<String, int> dishSales;

  BarChartWidget({required this.dishSales});

  @override
  Widget build(BuildContext context) {
    final barGroups = dishSales.entries.map((entry) {
      return BarChartGroupData(
        x: dishSales.keys.toList().indexOf(entry.key),
        barRods: [
          BarChartRodData(
            y: entry.value.toDouble(),
            colors: [Colors.blue],
          ),
        ],
      );
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 300,
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            barGroups: barGroups,
            titlesData: FlTitlesData(
              bottomTitles: SideTitles(
                showTitles: true,
                getTitles: (double value) {
                  int index = value.toInt();
                  if (index >= 0 && index < dishSales.keys.length) {
                    return dishSales.keys.elementAt(index);
                  }
                  return '';
                },
                margin: 16,
                reservedSize: 40,
                rotateAngle: 90,  // Rotar las etiquetas 90 grados
              ),
              leftTitles: SideTitles(showTitles: true),
            ),
          ),
        ),
      ),
    );
  }
}
