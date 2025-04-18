import 'package:flutter/material.dart';
import 'package:projet_tcm/widgets/my_graph.dart';

class DataPage extends StatefulWidget {
  final Map<String, dynamic> selectedSensor;

  const DataPage({super.key, required this.selectedSensor});

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && mounted) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 280.0,
                  width: 380.0,
                  child: Card(
                    color: Colors.grey.shade800,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: AspectRatio(
                      aspectRatio: 1.70,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 18,
                          left: 12,
                          top: 24,
                          bottom: 12,
                        ),
                        child: MyGraph(
                          idCapteur: widget.selectedSensor['Id_capteur'],
                          dateTime: selectedDate,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Remplissage du : ${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: _selectDate,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    width: 150.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.calendar_month, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          "Calendrier",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
