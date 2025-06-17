import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final Map<String, dynamic> selectedSensor;

  const HomePage({super.key, required this.selectedSensor});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.sensors_rounded, size: 100),
              const SizedBox(height: 20),
              Text(
                'Capteur sélectionné : ${selectedSensor['Id_capteur']}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Adresse : ${selectedSensor['Adresse']}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text('Position géographique : ${selectedSensor['Latitude']}, ${selectedSensor['Longitude']}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'Type : ${selectedSensor['Type']}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'Hauteur : ${selectedSensor['Hauteur']} m',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}