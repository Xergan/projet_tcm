import 'package:flutter/material.dart';
import 'package:projet_tcm/widgets/my_table.dart';

class AlertPage extends StatelessWidget {
  final Map<String, dynamic> selectedSensor;

  const AlertPage({super.key, required this.selectedSensor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(child: Card(elevation: 5.0, child: MyTable(idCapteur: selectedSensor['Id_capteur']))),
      ),
    );
  }
}