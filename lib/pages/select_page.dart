import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_tcm/blocs/sensor/sensor_cubit.dart';

class SelectPage extends StatefulWidget {
  const SelectPage({super.key});

  @override
  State<SelectPage> createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  @override
  void initState() {
    super.initState();
    context.read<SensorCubit>().fetchSensors();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sélectionnez un capteur')),
      body: BlocBuilder<SensorCubit, SensorState>(
        builder: (context, state) {
          if (state is SensorLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SensorLoaded) {
            return ListView.builder(
              itemCount: state.sensors.length,
              itemBuilder: (context, index) {
                final sensor = state.sensors[index];

                return SensorTemplate(
                  sensorId: sensor["Id_capteur"],
                  onTap: () {
                    print('Capteur sélectionné : ${sensor["Id_capteur"]}');
                  },
                );
              },
            );
          } else if (state is SensorError) {
            return Center(child: Text(state.errorMessage));
          } else {
            return const Center(child: Text('Aucun capteur disponible.'));
          }
        },
      ),
    );
  }
}

class SensorTemplate extends StatelessWidget {
  final String sensorId;
  final VoidCallback onTap;

  const SensorTemplate({
    super.key,
    required this.sensorId,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              sensorId,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}
